import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shom_gn/consts/widget_constants.dart';


class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final IconData? icon;
  final TextInputType? textInputType;
  final String? hinterText;
  final String? Function(String?)? validator;
  final double? fontSize;
  final String? fontFamily;
  final bool? isFullBorder;
  final String? labelText;
    final ValueChanged<String>? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final int? maxLines;


  const InputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.icon,
    this.textInputType,
    this.hinterText,
    this.validator,
    this.fontSize,
    this.fontFamily,
    this.isFullBorder = false,
    this.labelText = '',
        required this.onChange,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: WidgetConstants.sepWidgetHeight * 1.5,
        right: WidgetConstants.sepWidgetHeight * 1.5,
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
         readOnly: readOnly ?? false,
        maxLines: maxLines,
        textInputAction: TextInputAction.next,
        keyboardType: textInputType,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocusNode!);
        },
        validator: validator,
        onChanged: onChange,
      ),
      
    );
  }
}


