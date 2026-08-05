import 'package:flutter/widgets.dart';

class DisplayWidgetTitle extends StatelessWidget {
  const DisplayWidgetTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = 18.0,
     this.fontWeight = FontWeight.bold
  });
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
        text ?? '',
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
        textAlign: textAlign,
    );
  }
}
