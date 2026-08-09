import 'package:flutter/material.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/widgets/input/password_widget.dart';

class RepeatPasswordWidget extends StatefulWidget {
  final TextEditingController passwordController, repeatPasswordController;
  final FocusNode passwordFocusNode, repeatPasswordFocusNode;

  const RepeatPasswordWidget({
    super.key,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.passwordFocusNode,
    required this.repeatPasswordFocusNode,
  });
  @override
  State<StatefulWidget> createState() => RepeatPasswordWidgetState();
}

class RepeatPasswordWidgetState extends State<RepeatPasswordWidget> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordWidget(
          passwordController: widget.passwordController,
          passwordFocusNode: widget.passwordFocusNode,
          obscureText: obscureText,
          onPressObscur: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          hintText: AppLocalizations.of(context)!.input_hint_password,
        ),
        SizedBox(height: WidgetConstants.sepWidgetHeight),
        PasswordWidget(
          passwordController: widget.repeatPasswordController,
          passwordFocusNode: widget.repeatPasswordFocusNode,
          obscureText: obscureText,
          onPressObscur: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          hintText: AppLocalizations.of(context)!.input_hint_password_repeat,
          validator: (value) {
            return MyValidators.repeatPasswordValidator(
              value: value,
              password: widget.passwordController.text,
            );
          },
        ),
      ],
    );
  }
}
