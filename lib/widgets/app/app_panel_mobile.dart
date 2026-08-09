import 'package:flutter/material.dart';

class AppPanelMobile  extends StatelessWidget{
final List<Widget> childrens;

  const AppPanelMobile({super.key, required this.childrens});

  @override
  Widget build(BuildContext context) {
        return Center(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: childrens
              ),
            ),
          ),
        ),
      ),
    );
  }
}