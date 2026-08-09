import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/widgets/input/input_widget.dart';

class PasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final bool obscureText;
  final VoidCallback onPressObscur;
  final String? hintText;
  final String? Function(String?)? validator;
  final FocusNode? nextFocusNode;

  const PasswordWidget({
    super.key,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.obscureText,
    required this.onPressObscur,
    this.hintText = "***********",
    this.validator,
    this.nextFocusNode,
  });
  @override
  State<StatefulWidget> createState() => PasswordWidgetState();
}

class PasswordWidgetState extends State<PasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: widget.passwordController,
      focusNode: widget.passwordFocusNode,
      prefixIcon: Icon(Icons.lock),
      nextFocusNode: widget.nextFocusNode,
      textInputType: TextInputType.visiblePassword,
      hintText: widget.hintText,
      validator:
          widget.validator ??
          (value) {
            return MyValidators.passwordValidator(value);
          },
      onChange: (String value) {},
      fontSize: 14,
      fontFamily: 'Roboto',
      fontweight: FontWeight.bold,
      isFullBorder: true,
      obscureText: widget.obscureText,
      suffixIcon: IconButton(
        onPressed: widget.onPressObscur,
        padding: EdgeInsets.only(right: 6),
        icon: Icon(
          widget.obscureText == true ? Icons.visibility : Icons.visibility_off,
        ),
        style: Theme.of(context).iconButtonTheme.style!.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.selectionColor;
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.selectionColor;
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.primary;
            }
            return AppColors.primary;
          }),
        ),
      ),
      //   onPressObscur: widget.onPressObscur,
    );
  }
}
