import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/models/opt_args_model.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/services/interfaces/i_user_service.dart';
import 'package:shom_gn/services/my_app_functions.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/auth/auth_link_widget.dart';
import 'package:shom_gn/widgets/auth/other_registration_widget.dart';
import 'package:shom_gn/widgets/auth/validation_button.dart';
import 'package:shom_gn/widgets/input/input_phone_widget.dart';



class LoginPhoneNumberPage extends StatefulWidget {
  const LoginPhoneNumberPage({super.key});

  @override
  State<LoginPhoneNumberPage> createState() => LoginPhoneNumberPageState();
}

class LoginPhoneNumberPageState extends State<LoginPhoneNumberPage> {
  late final TextEditingController _phoneNumberController;
  late final FocusNode _phoneNumberFocusNode;
  late UserService userService;

  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  FirebaseAuth? auth;

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    _phoneNumberFocusNode = FocusNode();
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
      _phoneNumberController.dispose();
      _phoneNumberFocusNode.dispose();
    }
    super.dispose();
  }

  String? verificationId;

  Future<void> _loginFct( ButtonInfo item) async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid && item.enabled) {
      try {
        setState(() {
          isloading = true;
        });
        if (kIsWeb) {
          ConfirmationResult? confirmationResult = await auth
              ?.signInWithPhoneNumber(_phoneNumberController.text);

          UserModel user = await userService.initializeUserWithPhone(
            _phoneNumberController.text,
            UserRole.user
          );
          OptArgsModel args = OptArgsModel(
            verificationId: confirmationResult!.verificationId,
            currentUser: user,
            confirmationResult: confirmationResult,
          );
          context.push(item.routeName!, extra: args);
        } else {
          userService.registerWithPhone(
            context,
            userService.initializeUserWithPhone(_phoneNumberController.text , UserRole.user)
                as UserModel,
          );
        }
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputPhoneWidget(
                  phoneController: _phoneNumberController,
                  phoneFocusNode: _phoneNumberFocusNode,
                  nextFocusNode: _phoneNumberFocusNode,
                  fontSize:
                      Responsive.isDesktop(context)
                          ? WidgetConstants.subTitleFontSize
                          : 16,
                ),
                AuthLinkWidget(),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ValidationButton(
                    fn: _loginFct,
                    buttonItem: ButtonInfo(
                     title:  AppLocalizations.of(context)!.label_login,
                     enabled:  true,
                      routeName: RouteConstants.OTP_SCREEN_ROUTE,
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
