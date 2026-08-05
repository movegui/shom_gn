import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/widgets/menu/menu_item_widget.dart';
import 'package:shom_gn/widgets/menu/menuitem.dart';


class UserMenuScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Function(String) onTitleChange;

  const UserMenuScreen({
    super.key,
    required this.navigatorKey,
    required this.onTitleChange,
  });
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      offset: const Offset(0, 50),
      icon: const Icon(Icons.person, color: Color(0xFFFFFFFF)),
      onSelected: (MenuItem item) {
        navigatorKey.currentState?.pushNamed(item.route);
      },
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(AppColors.selectionColor),
      ),
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<MenuItem>>[
            PopupMenuItem<MenuItem>(
              child: MenuItemWidget(
                title: 'Login',
                route: '/login',
              ),
            ),
            PopupMenuItem<MenuItem>(
              child: MenuItemWidget(
                title: 'Enregistrer',
                route: '/register',
              ),
            ),
          ],
    );
  }
}
