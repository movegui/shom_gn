
import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget{
final double? height;
final double? width;

const SeparatorWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width,);
  }
}