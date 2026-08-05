import 'package:flutter/cupertino.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget({
    super.key,
    required this.label,
    this.fontSize = 20,
    this.color,
    this.maxLines,
    this.decoration,
  });

  final String label;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      // textAlign: TextAlign.justify,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          decoration: decoration,
          decorationColor: color,
          decorationStyle: TextDecorationStyle.double),
         
    );
  }
}
