import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/services/my_app_functions.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/app/separator_widget.dart';
import 'package:shom_gn/widgets/auth/other_registration_widget.dart';
import 'package:shom_gn/widgets/auth/repeat_password_widget.dart';
import 'package:shom_gn/widgets/auth/validation_button.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  State<StatefulWidget> createState() => RegisterEmailPageState();
}

class RegisterEmailPageState extends State<RegisterEmailPage> {
  bool obscureText = true;
  late final TextEditingController _emailController,
      _passwordController,
      _repeatPasswordController;

  late final FocusNode _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  FirebaseAuth? auth;
  late UserService userService;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    userService = getIt<UserService>();
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
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      _repeatPasswordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _registerFCT( ButtonInfo item) async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });
        UserModel initUser = await userService.initializeUserWithEmail(
          _emailController.text.trim(),
        );

        UserModel? createUser = await userService.registerWithEmail(
          context,
          initUser,
          _passwordController.text.trim(),
        );
        context.push(item.routeName!, extra: createUser);
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.success_registration_new_user,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (error) {
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: () {},
        );
      } finally {
        isloading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.input_hint_adress_email,
              prefixIcon: const Icon(IconlyLight.message),
            ),
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            validator: (value) {
              return MyValidators.emailValidator(value);
            },
          ),

          const SizedBox(height: 8.0),
          RepeatPasswordWidget(
            passwordController: _passwordController,
            repeatPasswordController: _repeatPasswordController,
            passwordFocusNode: _passwordFocusNode,
            repeatPasswordFocusNode: _repeatPasswordFocusNode,
          ),
          Responsive.isDesktop(context)
              ? SeparatorWidget(height: 20)
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(WidgetConstants.sepWidget),
            child: ValidationButton(
              fn: _registerFCT,
              buttonItem: ButtonInfo(
               title:  AppLocalizations.of(context)!.btn_register_label,
               enabled:  true,
                routeName: RouteConstants.PROFILE_ROUTE,
              ),
            ),
          ),
          Responsive.isDesktop(context)
              ? SeparatorWidget(height: 20)
              : SizedBox(),
          OtherRegistrationWidget(),
        ],
      ),
    );
  }
}
