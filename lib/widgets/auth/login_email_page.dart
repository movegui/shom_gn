import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/services/my_app_functions.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/auth/auth_link_widget.dart';
import 'package:shom_gn/widgets/auth/other_registration_widget.dart';
import 'package:shom_gn/widgets/auth/validation_button.dart';
import 'package:shom_gn/widgets/input/input_email_widget.dart';
import 'package:shom_gn/widgets/input/password_widget.dart';


class LoginEmailPage extends ConsumerStatefulWidget {
  const LoginEmailPage({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginEmailPageState();
  }



class LoginEmailPageState extends ConsumerState<LoginEmailPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late UserService userService;


  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;

  bool isloading = false;
  FirebaseAuth? auth;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    try {
      auth = FirebaseAuth.instance;
    } catch (e) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle:
            AppLocalizations.of(
              context,
            )!.error_firebase_initialisation.toString(),
        fct: () {},
      );
    }
    userService = getIt<UserService>();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }


Future<void> _loginFct( ButtonInfo item) async {
  final isValid = _formkey.currentState!.validate();
  FocusScope.of(context).unfocus();

  if (!isValid || !item.enabled) return;

  final l10n = AppLocalizations.of(context)!;

  if (mounted) {
    setState(() {
      isloading = true;
    });
  }

  try {
    final userCredential = await auth!.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (userCredential.user == null) {
      if (!mounted) return;

      Fluttertoast.showToast(
        msg: l10n.error_login_message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
      if(!mounted) return;
     await userService.checkLoginState(l10n.error_login_user_not_found);
    
    final currentUser = await userService.getByEmail(auth!.currentUser?.email! ?? '');
    if(currentUser == null) {
      if (!mounted) return;
       await userService.signOut();
      Fluttertoast.showToast(
        msg: l10n.error_login_message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    if (!mounted) return;
    ref.read(userProviderState).setUser(currentUser);

    Fluttertoast.showToast(
      msg: l10n.success_login_message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green, // success besser grün :)
      textColor: Colors.white,
      fontSize: 16.0,
    );

    context.go(item.routeName!);
  } on FirebaseAuthException catch (e) {
    if (!mounted) return;

    MyAppFunctions.showErrorOrWarningDialog(
      context: context,
      subtitle: e.message ?? l10n.exception_login_message,
      fct: () {},
    );
  } finally {
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputEmailWidget(
                  nextFocusNode: _passwordFocusNode,
                  emailController: _emailController,
                  emailFocusNode: _emailFocusNode,
                ),
                SizedBox(height: WidgetConstants.sepWidgetHeight),
                PasswordWidget(
                  passwordController: _passwordController,
                  passwordFocusNode: _passwordFocusNode,
                  obscureText: obscureText,
                  onPressObscur: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
                AuthLinkWidget(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ValidationButton(
                    fn: _loginFct,
                    buttonItem: ButtonInfo(
                      title: AppLocalizations.of(context)!.label_login,
                      enabled: true,
                      routeName: RouteConstants.PROFILE_ROUTE,
                    ),
                   icon: Icon(Icons.login , size: 24,),
                  ),
                ),
                OtherRegistrationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
