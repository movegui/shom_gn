import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/app/separator_widget.dart';
import 'package:shom_gn/widgets/auth/other_registration_widget.dart';
import 'package:shom_gn/widgets/auth/validation_button.dart';
import 'package:shom_gn/widgets/input/input_phone_widget.dart';

class RegisterPhonePage extends StatefulWidget {
  const RegisterPhonePage({super.key});

  @override
  State<RegisterPhonePage> createState() => RegisterPhonePageState();
}

class RegisterPhonePageState extends State<RegisterPhonePage> {
  FirebaseAuth? auth;

  late final TextEditingController _phoneNumberController;
  late final FocusNode _phoneNumberFocusNode;
  late UserService userService;
  late UserModel currentUser;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    _phoneNumberFocusNode = FocusNode();
    auth = FirebaseAuth.instance;
    userService = getIt<UserService>();
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

  Future<void> _registerFCT(BuildContext context, ButtonInfo item) async {
    currentUser = await userService.initializeUserWithPhone(
      _phoneNumberController.text,
    );
    print(currentUser.toJson());
    await userService.registerWithPhone(context, currentUser);
  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Column(
      children: [
        Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputPhoneWidget(
                phoneController: _phoneNumberController,
                phoneFocusNode: _phoneNumberFocusNode,
              ),
              Responsive.isDesktop(context)
                  ? SeparatorWidget(height: 20)
                  : SizedBox(),
              ValidationButton(
                fn: (ButtonInfo item) async {
                  await _registerFCT(context, item);
                },
                buttonItem: ButtonInfo(
                 title:  AppLocalizations.of(context)!.btn_register_label,
                 enabled:  true,
                  routeName: RouteConstants.REGISTER_ROUTE,
                ),
              ),
              Responsive.isDesktop(context)
                  ? SeparatorWidget(height: 20)
                  : SizedBox(),
              OtherRegistrationWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
