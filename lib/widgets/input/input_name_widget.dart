
import 'package:flutter/material.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/widgets/input/input_widget.dart';

class InputNameWidget extends StatelessWidget {
  final TextEditingController nameController;
  final FocusNode nameFocusNode;
  final FocusNode? nextFocusNode;
  final String? hinterText;

  const InputNameWidget({
    super.key,
    required this.nameController,
    required this.nameFocusNode,
    this.nextFocusNode,
    required this.hinterText, 
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: nameController,
      focusNode: nameFocusNode,
      icon: Icons.person,
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.name,
      hinterText: hinterText!,
      validator: (value) {
        return MyValidators.textNameValidator(value);
      }, onChange: (String value) {  },
    );
  }
}
