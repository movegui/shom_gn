import 'package:flutter/material.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/widgets/input/input_widget.dart';

class InputEmailWidget extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final FocusNode? nextFocusNode;


  const InputEmailWidget({
    super.key,
    this.nextFocusNode,
    required this.emailController,
    required this.emailFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: emailController,
      focusNode: emailFocusNode,
      prefixIcon: Icon(Icons.mail),
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.emailAddress,
      hintText: AppLocalizations.of(context)!.input_hint_adress_email,
      validator: (value) {
        return MyValidators.emailValidator(value);
      },
      onChange: (String value) {},
      fontSize: 14,
      fontFamily: 'Roboto',  
      fontweight: FontWeight.bold,
      isFullBorder: true,
    );
  }
}
