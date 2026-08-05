import 'package:flutter/material.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/consts/widget_constants.dart';


class PasswordWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final bool obscureText;
  final VoidCallback onPressObscur;


  const PasswordWidget({
    super.key,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.obscureText,
    required this.onPressObscur,

  });

 @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: WidgetConstants.sepWidgetHeight * 1.5,
        right: WidgetConstants.sepWidgetHeight * 1.5,
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: passwordController,
        focusNode: passwordFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          return MyValidators.passwordValidator(value);
        },
      ),
    );
  }
}
