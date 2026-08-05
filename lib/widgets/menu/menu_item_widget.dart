import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key,
    required this.title,
    required this.route,
  });
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(route);
      },
      child: Card(
        color: Color(0xFF871A1C),
        margin: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
