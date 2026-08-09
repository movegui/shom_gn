import 'dart:io';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/app_constants.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/person_model.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/screens/auth/login_screen.dart';
import 'package:shom_gn/services/image_service.dart';
import 'package:shom_gn/services/interfaces/i_user_service.dart';
import 'package:shom_gn/services/my_app_functions.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/auth/movegui_profile_header_widget.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';
import 'package:shom_gn/widgets/util/profile_menu_title.dart';

import 'package:uuid/uuid.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key, this.currentUser});
  final UserModel? currentUser;

  @override
  State<StatefulWidget> createState() => MoveguiProfileScreenState();
}

class MoveguiProfileScreenState extends State<MyProfileScreen> {
  FirebaseAuth? auth;
  File? pickedImage;
  Uint8List? webImage;
  late String gender;
  late DateTime birthdate;
  late UserModel? currentUser;
  late UserService userService;
  late ImageService imageService;
  late TextEditingController nameController;
  late FocusNode nameFocusNode;
  XFile? _pickedImage;
  late bool isNew;
  late int loginMode = -1;
  late bool isEditing;

  Future<void> onNameUpdate(String? value) async {
    final updatedUser = await userService.updateUsername(
      value ?? '',
      currentUser!,
    );
    if (updatedUser != null) {
      setState(() {
        currentUser = updatedUser;
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.success_login_message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        isEditing = false;
      });
    } else {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_send_mail_title,
        AppLocalizations.of(context)!.error_send_mail_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.camera,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        await updloadImage(bytes);
        setState(() {
          webImage = bytes;
        });
      },
      galleryFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        await updloadImage(bytes);
        setState(() {
          webImage = bytes;
        });
      },
      removeFCT: () {
        setState(() {
          webImage = null;
          pickedImage = null;
        });
      },
    );
  }

  Future<void> updloadImage(Uint8List? bytes) async {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null && currentUser != null) {
        String? url = await imageService.uploadImage(
          file: null,
          webBytes: bytes,
          collectionName: userService.getCollectionName(),
        );
        UserModel updatedUser = UserModel(
          updatedAt: DateTime.now(),
          id: currentUser!.id,
          name: currentUser!.name,
          createdAt: currentUser!.createdAt,
          username: currentUser!.username,
          isVerified: currentUser!.isVerified,

          personModel: PersonModel(
            id: currentUser!.personModel!.id,
            name: currentUser!.name,
            createdAt: DateTime.now(),
            firstName: currentUser!.name,
            lastName: currentUser!.personModel!.lastName,
            profileImageUrl: url,
            email: currentUser!.personModel!.email,
            phone: currentUser!.personModel!.phone,
            gender: currentUser!.personModel!.gender,
            birthDate: currentUser!.personModel!.birthDate,
            addresses: currentUser!.personModel!.addresses,
          ),
          role: '',
        );
        if (isNew) {
          await userService.addModel(updatedUser);
        } else {
          await userService.update(updatedUser);
          isNew = false;
        }
        setState(() {
          currentUser = updatedUser;
        });
      } else {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_send_mail_title,
          AppLocalizations.of(context)!.error_send_mail_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }
    });
  }

  @override
  void initState() {
    userService = getIt<UserService>();
    imageService = getIt<ImageService>();
    auth = FirebaseAuth.instance;
    currentUser = null;
    nameController = TextEditingController();
    nameFocusNode = FocusNode();
    isNew = false;
    isEditing = false;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await userService.checkLoginState(
        AppLocalizations.of(context)!.error_login_user_not_found,
      );
      await _initialize();
    });
  }

  Future<void> _initialize() async {
    if (widget.currentUser != null) currentUser = widget.currentUser;

    if (auth?.currentUser != null) {
      if (auth?.currentUser?.email != null) {
        if (loginMode != AppConstants.LONGIN_EMAIL_MODE) {
          loginMode = AppConstants.LONGIN_EMAIL_MODE;
          //     context.read<LoginModProvider>().setLoginMod(loginMode);
        }
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            currentUser = await userService.getByEmail(
              auth?.currentUser?.email ?? '',
            );
            isNew = false;
            setState(() {});
          });
        });
      } else if (auth?.currentUser?.phoneNumber != null) {
        if (loginMode != AppConstants.LOGIN_PHONE_MODE) {
          loginMode = AppConstants.LOGIN_PHONE_MODE;
        }
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            currentUser = await userService.getByPhone(
              auth?.currentUser?.phoneNumber ?? '',
            );
            isNew = false;
            setState(() {});
          });
        });
      }
      if (currentUser == null) {
        isNew = true;
        if (loginMode == AppConstants.LOGIN_PHONE_MODE) {
          {
            setState(() {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                currentUser =
                    await userService.initializeUserWithPhone(
                          auth!.currentUser!.phoneNumber!,
                          UserRole.user
                        )
                        as UserModel?;
              });
            });
          }
        } else if (loginMode == AppConstants.LONGIN_EMAIL_MODE) {
          setState(() {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              currentUser =
                  await userService.initializeUserWithEmail(
                        auth!.currentUser!.email!,
                      )
                      as UserModel?;
            });
          });
        } else {
          setState(() {
            currentUser = UserModel(
              updatedAt: DateTime.now(),
              id: auth?.currentUser?.uid ?? '',
              name: auth?.currentUser?.displayName ?? '',
              createdAt: DateTime.now(),
              username: loginMode == AppConstants.LONGIN_EMAIL_MODE
                  ? auth?.currentUser?.email
                  : loginMode == AppConstants.LOGIN_PHONE_MODE
                  ? auth?.currentUser?.phoneNumber
                  : null,
              isVerified: loginMode == AppConstants.LONGIN_EMAIL_MODE
                  ? auth!.currentUser!.emailVerified
                  : loginMode == AppConstants.LOGIN_PHONE_MODE
                  ? true
                  : false,
              personModel: PersonModel(
                id: Uuid().v4(),
                name: auth?.currentUser?.displayName ?? '',
                createdAt: DateTime.now(),
                firstName: '',
                lastName: auth?.currentUser?.displayName ?? '',
                profileImageUrl: null,
                email: loginMode == AppConstants.LONGIN_EMAIL_MODE
                    ? auth?.currentUser?.email
                    : null,
                phone: loginMode == AppConstants.LOGIN_PHONE_MODE
                    ? auth?.currentUser?.phoneNumber
                    : null,
                gender: '',
                birthDate: null,
                addresses: [],
              ),
              role: '',
            );
          });
        }
      }
    }
  }

  void navigateToRoute(String route) {
    context.push(route);
  }

  void chekLoginMode() {
    if (FirebaseAuth.instance.currentUser?.email != null) {
      /*
      context.read<LoginModProvider>().setLoginMod(
        AppConstants.LONGIN_EMAIL_MODE,
      );
      */
    } else if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
      /*
      context.read<LoginModProvider>().setLoginMod(
        AppConstants.LOGIN_PHONE_MODE,
      );
      */
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //     chekLoginMode();
          return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(
                  WidgetConstants.sepWidgetHeight * 2,
                ),
                children: [
                  headerProfile(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildFirstSection(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildSecondSection(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildThirdSection(),
                ],
              ),
            ),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }

  Widget _buildFirstSection() {
    return _sectionCard([
      currentUser != null
          ? ProfileMenuTitle(
              icon: Icons.logout,
              title: AppLocalizations.of(context)!.profile_menu_logout,
              onTap: () async {
                await userService.signOut();
                setState(() {
                  currentUser == null;
                });
              },
              enabled: true,
            )
          : ProfileMenuTitle(
              icon: Icons.login,
              title: AppLocalizations.of(context)!.profile_menu_login,
              onTap: () => context.push(RouteConstants.LOGIN_ROUTE),
              enabled: true,
            ),

      ProfileMenuTitle(
        icon: Icons.person_add,
        title: AppLocalizations.of(context)!.profile_menu_invite_people,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.list,
        title: AppLocalizations.of(context)!.profile_menu_orders,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.campaign,
        title: AppLocalizations.of(context)!.profile_menu_message,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.star_border,
        title: AppLocalizations.of(context)!.profile_menu_important,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.devices,
        title: AppLocalizations.of(context)!.profile_menu_devices,
        onTap: () => notImplemented(),
        enabled: false,
      ),
    ]);
  }

  Widget _buildSecondSection() {
    return _sectionCard([
      //  Divider(height: 3, indent: 56, color: Colors.grey.shade300),
      ProfileMenuTitle(
        icon: Icons.key,
        title: AppLocalizations.of(context)!.profile_menu_account,
        onTap: () => navigateToRoute(
          '${RouteConstants.PROFILE_ROUTE}${RouteConstants.ACCOUNT_ROUTE}/${currentUser?.id}',
        ),
        enabled: true,
      ),
      ProfileMenuTitle(
        icon: Icons.lock_outline,
        title: AppLocalizations.of(context)!.profile_menu_confidentiality,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.chat_bubble_outline,
        title: AppLocalizations.of(context)!.profile_menu_discussions,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.notifications_none,
        title: AppLocalizations.of(context)!.profile_menu_notification,
        onTap: () => notImplemented(),
        enabled: false,
      ),
    ]);
  }

  Widget _buildThirdSection() {
    return _sectionCard([
      ProfileMenuTitle(
        icon: Icons.delete,
        title: AppLocalizations.of(context)!.profile_menu_delete_account,
        onTap: () => notImplemented(),
        enabled: false,
      ),
    ]);
  }

  Widget _sectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(
          children.length,
          (index) => Column(
            children: [
              children[index],
              if (index != children.length - 1)
                const Divider(height: 1, indent: 56),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerProfile() {
    return MyProfileHeaderWidget(
      onNameUpdate: (value) async {
        onNameUpdate(value);
      },
      onPickImage: () async {
        localImagePicker();
      },
      currentUser: currentUser,
      nameController: nameController,
      nameFocusNode: nameFocusNode,
      pickedImage: pickedImage,
      webImage: webImage,
      isEditing: isEditing,
      onChangeEditing: (value) async {
        setState(() {
          isEditing = !value;
        });
      },
    );
  }

  Future<dynamic> notImplemented() {
    return MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }
}
