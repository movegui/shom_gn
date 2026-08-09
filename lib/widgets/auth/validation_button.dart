import 'package:flutter/material.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/widgets/util/button_widget.dart';


class ValidationButton extends StatelessWidget {
  final Future<void> Function( ButtonInfo item) fn;
  final ButtonInfo buttonItem;
  final Widget? icon;

  const ValidationButton({
    super.key,
    required this.fn,
    required this.buttonItem,
    this.icon ,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Flexible(
          child: Center(
            child: SizedBox(
              width: Responsive.isMobile(context) ? size.width * 0.5 : 400,
              child: ButtonWidget(
                onPressed: fn,
                buttonItem: buttonItem,
                icon: icon ?? Icon(Icons.send),
                textStyle: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
