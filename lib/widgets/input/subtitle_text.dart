import 'package:flutter/material.dart';

class SubtitleTextWidget extends StatelessWidget {
  final String label;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? textDecoration;
  const SubtitleTextWidget({
    super.key,
    required this.label,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.color,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        color: color,
        fontStyle: fontStyle,
      ),
    );
  }
}
