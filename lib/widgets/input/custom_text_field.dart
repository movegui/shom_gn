import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.hintText,
    this.inputType,
    this.onChanged,
    this.obscureText = false,
    this.validator,
    required this.hasIcon,
    this.onTap,
    required this.isNumber,
    this.controller,
    this.isEnabled,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.icon,
    this.labelText,
    this.maxLines,
  });

  Function(String)? onChanged;
  String? hintText;
  TextInputType? inputType;
  bool obscureText;
  bool? isEnabled;
  final bool hasIcon;
  final FormFieldValidator<String>? validator;
  final Function? onTap;
  final bool isNumber;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  String? labelText;
  IconData? icon;
  int? maxLines;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        enabled: isEnabled ?? true,
        controller: controller,
        focusNode: focusNode,
        validator: validator,
        obscureText: obscureText,
        onChanged: onChanged,
        keyboardType: inputType,
        maxLines: maxLines,
        textInputAction: textInputAction,
        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
            : null,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
      ),
    );
  }
}
