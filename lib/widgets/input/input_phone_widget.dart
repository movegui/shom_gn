import 'package:flutter/material.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/widgets/input/input_widget.dart';

class InputPhoneWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final FocusNode? nextFocusNode;
  final double? fontSize;
  final String? fontFamily;

  const InputPhoneWidget({
    super.key,
    required this.phoneController,
    required this.phoneFocusNode,
    this.nextFocusNode,
    this.fontSize,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: phoneController,
      focusNode: phoneFocusNode,
      prefixIcon:Icon(Icons.phone),
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.phone,
      hintText: '+224 601 00 00 00',
      validator: (value) {
        return MyValidators.phoneNumberValidator(value);
      },
      onChange: (String value) {},
      fontSize: 14,
      fontFamily: 'Roboto',
      fontweight: FontWeight.bold,
      isFullBorder: true,
    );
  }
}
