import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/opt_args_model.dart';
import 'package:shom_gn/models/person_model.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/screens/auth/otp_verification_screen.dart';
import 'package:shom_gn/services/interfaces/i_user_service.dart';
import 'package:shom_gn/services/model_service.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';

import 'package:uuid/uuid.dart';

class UserService extends ModelService<UserModel> implements IUserService {
  final auth = FirebaseAuth.instance;

  UserService({required super.api});
  @override
  Future<UserModel> addModel(UserModel model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .set(model.toJson());
    return model;
  }

  @override
  Future<List<UserModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  @override
  Future<List<UserModel>> getByName(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('name', isEqualTo: name)
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  @override
  String getCollectionName() {
    return "users";
  }

  @override
  Future<UserModel?> getByUsername(String username) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('username', isEqualTo: username)
        .get();

    if (snapshot.docs.isEmpty) return null;

    return UserModel.fromJson(snapshot.docs.first.data());

    //  return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).first;
  }

  @override
  Future<void> registerWithAppleId(UserModel model) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> registerWithEmail(
    BuildContext context,
    UserModel model,
    String password,
  ) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: model.personModel!.email!,
            password: password,
          );
      User? user = credential.user;
      print('the user is: ${user?.email}');
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      if (user!.emailVerified) {
        model.isVerified = true;
      }
      await addModel(model);
      return model;
    } on FirebaseException catch (e) {
      print('error');
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        AppLocalizations.of(context)!.error_register_with_phone_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
      throw Exception(e);
    }
  }

  static const String _googleSignInClientId = String.fromEnvironment(
    'GOOGLE_SIGN_IN_CLIENT_ID',
  );

  @override
  Future<UserModel?> registerWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn =
          kIsWeb && _googleSignInClientId.isNotEmpty
          ? GoogleSignIn(clientId: _googleSignInClientId)
          : GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User cancelled sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception("Firebase user is null");
      }

      // Check if user exists in Firestore
      UserModel? existingUser = await getByEmail(firebaseUser.email ?? '');

      if (existingUser != null) {
        return existingUser;
      }

      // Create new user if doesn't exist
      final UserModel newUser = await initializeUserWithAuthenticateUser(
        firebaseUser,
      );

      await addModel(newUser);
      return newUser;
    } on FirebaseException catch (e) {
      print(e.message);
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        'Google Sign-In Error: ${e.message}',
        const Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } catch (e) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        'Error: $e',
        const Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
    return null;
  }

  Future<UserModel?> registerWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.cancelled) {
        return null; // User cancelled sign-in
      }

      if (result.status == LoginStatus.failed) {
        throw Exception(result.message ?? 'Facebook login failed');
      }

      final AccessToken? accessToken = result.accessToken;
      if (accessToken == null) {
        throw Exception('Access token is null');
      }

      final credential = FacebookAuthProvider.credential(
        accessToken.tokenString,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception("Firebase user is null");
      }

      // Check if user exists in Firestore
      UserModel? existingUser = await getByEmail(firebaseUser.email ?? '');

      if (existingUser != null) {
        return existingUser;
      }

      // Create new user if doesn't exist
      final UserModel newUser = await initializeUserWithAuthenticateUser(
        firebaseUser,
      );

      await addModel(newUser);
      return newUser;
    } on FirebaseException catch (e) {
      print(e.message);
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        'Facebook Sign-In Error: ${e.message}',
        const Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } catch (e) {
      print(e);
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        'Error: $e',
        const Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
    return null;
  }

  @override
  Future<void> registerWithPhone(BuildContext context, UserModel user) async {
    if (kIsWeb) {
      final confirmationResult = await FirebaseAuth.instance
          .signInWithPhoneNumber(user.personModel?.phone ?? '');

      OptArgsModel args = OptArgsModel(
        verificationId: confirmationResult.verificationId,
        currentUser: user,
        confirmationResult: confirmationResult,
      );
      if (!context.mounted) return;
      print('je suis la ');
      context.push(RouteConstants.OTP_SCREEN_ROUTE, extra: args);
    /*  
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            confirmationResult: confirmationResult,
            currentUser: user,
            verificationId: '',
          ),
        ),
      );
      */
      

      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: user.personModel!.phone,
      verificationCompleted: (credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        // erreur
      },
      codeSent: (verificationId, resendToken) {
        OptArgsModel args = OptArgsModel(
          verificationId: verificationId,
          currentUser: user,
          confirmationResult: null,
        );
        if (!context.mounted) return;
          context.push(RouteConstants.OTP_SCREEN_ROUTE, extra: args);
   

      /*  
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(
              verificationId: verificationId,
              currentUser: user,
            ),
          ),
        );
        */
        
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  /*
  @override
  Future<void> registerWithPhone(BuildContext context, UserModel user) async {
    ConfirmationResult? confirmationResult = null;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: user.personModel!.phone,
      verificationCompleted: (credential) async {
        if(kIsWeb){
           confirmationResult =
    await FirebaseAuth.instance.signInWithPhoneNumber(
      user.personModel!.phone,
    );
        }else {
          await FirebaseAuth.instance.signInWithCredential(credential);
        }
        
      },
      verificationFailed: (e) {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_register_with_phone_title,
          AppLocalizations.of(context)!.error_register_with_phone_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => OtpVerificationScreen(
                  verificationId: verificationId,
                  currentUser: user,
                  confirmationResult: confirmationResult
                ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }
  */

  @override
  Future<UserCredential> verifyOtp(
    String verificationId,
    String smsCode,
  ) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<UserModel?> getByEmail(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('person.email', isEqualTo: email.trim().toLowerCase())
        .get();

    if (snapshot.docs.isEmpty) return null;
    return UserModel.fromJson(snapshot.docs.first.data());
    // return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).first;
  }

  @override
  Future<UserModel?> getByPhone(String phone) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('person.phone', isEqualTo: phone)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return UserModel.fromJson(snapshot.docs.first.data());
    // return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).first;
  }

  Future<UserModel> getById(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception("User not found");
    }

    return UserModel.fromJson(snapshot.data()!);
  }

  @override
  Future<void> update(UserModel model) async {
    return FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .update(model.toJson());
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserModel> initializeUserWithPhone(
    String phoneNumber,
    UserRole role,
  ) async {
    late UserModel currentUser;

    currentUser = UserModel(
      updatedAt: DateTime.now(),
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      username: phoneNumber,
      isVerified: false,
      role: role.name,
      personModel: PersonModel(
        id: Uuid().v4(),
        name: phoneNumber,
        createdAt: DateTime.now(),
        firstName: '',
        lastName: '',
        profileImageUrl: null,
        email: null,
        phone: phoneNumber,
        gender: '',
        birthDate: null,
        addresses: [],
      ),
    );
    return currentUser;
  }

  Future<UserModel> initializeUserWithEmail(String email) async {
    late UserModel currentUser;

    currentUser = UserModel(
      updatedAt: DateTime.now(),
      id: Uuid().v4(),
      name: email,
      createdAt: DateTime.now(),
      username: email,
      isVerified: false,
      role: '',
      personModel: PersonModel(
        id: Uuid().v4(),
        name: '',
        createdAt: DateTime.now(),
        firstName: '',
        lastName: '',
        profileImageUrl: null,
        email: email,
        phone: null,
        gender: '',
        birthDate: null,
        addresses: [],
      ),
    );
    return currentUser;
  }

  Future<UserModel> initializeUserWithAuthenticateUser(
    User firebaseUser,
  ) async {
    return UserModel(
      updatedAt: DateTime.now(),
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? firebaseUser.email ?? 'Google User',
      createdAt: DateTime.now(),
      username: firebaseUser.email ?? '',
      isVerified: firebaseUser.emailVerified,
      role: '',
      personModel: PersonModel(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? '',
        createdAt: DateTime.now(),
        firstName: firebaseUser.displayName?.split(' ').first ?? '',
        lastName: firebaseUser.displayName?.split(' ').skip(1).join(' ') ?? '',
        profileImageUrl: firebaseUser.photoURL,
        email: firebaseUser.email,
        phone: null,
        gender: '',
        birthDate: null,
        addresses: [],
      ),
    );
  }

  @override
  Future<UserModel> getModelById(String id) {
    return getById(id);
  }

  Future<void> initUser(WidgetRef ref) async {
    final user = ref.watch(userProviderState).user;
    if (user == null) {
      final currentUser = await getByEmail(
        FirebaseAuth.instance.currentUser!.email!,
      );
      if (currentUser != null) {
        ref.read(userProviderState).setUser(currentUser);
      }
    }
  }

  @override
  Future<void> checkLoginState(String message) async {
    final currentUser = await getByEmail(
      FirebaseAuth.instance.currentUser?.email! ?? '',
    );
    if (currentUser == null) {
      await signOut();
      Fluttertoast.showToast(
        msg: message.isNotEmpty
            ? message
            : 'User not found in the database, please check your email and password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
  }

  @override
  Future<UserModel?> updateUsername(
    String value,
    UserModel? currentUser,
  ) async {
    if (value.isNotEmpty && currentUser != null) {
      UserModel updatedUser = UserModel(
        updatedAt: DateTime.now(),
        id: currentUser.id,
        name: value,
        createdAt: currentUser.createdAt,
        username: currentUser.username,
        personModel: currentUser.personModel,
        isVerified: currentUser.isVerified,
        role: '',
      );
      await update(updatedUser);
      return updatedUser;
    }
    return null;
  }

  @override
  Future<UserModel?> updateUserEmail(
    String value,
    UserModel? currentUser,
  ) async {
    if (value.isNotEmpty && currentUser != null) {
      UserModel updatedUser = UserModel(
        updatedAt: DateTime.now(),
        id: currentUser.id,
        name: currentUser.name,
        createdAt: currentUser.createdAt,
        username: currentUser.username,
        personModel: PersonModel(
          id: currentUser.personModel?.id ?? '',
          name: currentUser.personModel?.name ?? '',
          createdAt: currentUser.personModel?.createdAt ?? DateTime.now(),
          firstName: currentUser.personModel?.firstName ?? '',
          lastName: currentUser.personModel?.lastName ?? '',
          profileImageUrl: currentUser.personModel?.profileImageUrl,
          email: value,
          phone: currentUser.personModel?.phone,
          gender: currentUser.personModel?.gender ?? '',
          birthDate: currentUser.personModel?.birthDate,
          addresses: currentUser.personModel?.addresses ?? [],
        ),
        isVerified: currentUser.isVerified,
        role: '',
      );
      await update(updatedUser);
      return updatedUser;
    }
    return null;
  }

  @override
  Future<UserModel?> updateUserPhone(
    String value,
    UserModel? currentUser,
  ) async {
    if (value.isNotEmpty && currentUser != null) {
      UserModel updatedUser = UserModel(
        updatedAt: DateTime.now(),
        id: currentUser.id,
        name: currentUser.name,
        createdAt: currentUser.createdAt,
        username: currentUser.username,
        personModel: PersonModel(
          id: currentUser.personModel?.id ?? '',
          name: currentUser.personModel?.name ?? '',
          createdAt: currentUser.personModel?.createdAt ?? DateTime.now(),
          firstName: currentUser.personModel?.firstName ?? '',
          lastName: currentUser.personModel?.lastName ?? '',
          profileImageUrl: currentUser.personModel?.profileImageUrl,
          email: currentUser.personModel?.email ?? '',
          phone: value,
          gender: currentUser.personModel?.gender ?? '',
          birthDate: currentUser.personModel?.birthDate,
          addresses: currentUser.personModel?.addresses ?? [],
        ),
        isVerified: currentUser.isVerified,
        role: '',
      );
      await update(updatedUser);
      return updatedUser;
    }
    return null;
  }

  @override
  Future<void> deleteAccount(BuildContext context) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.compte_delete_title),
        content: Text(AppLocalizations.of(context)!.compte_delete_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.btn_cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.btn_delete),
          ),
        ],
      ),
    );
    if (result != true) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      await FirebaseAuth.instance.currentUser?.delete();
      if (context.mounted) {
        context.go(RouteConstants.LOGIN_ROUTE);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
