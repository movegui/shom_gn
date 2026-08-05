
import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;

  const DisplayWidget({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
    );
  }
}
