import 'package:flutter/material.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/widgets/menu/menu_item_widget.dart';


class MyMenu extends StatelessWidget {
  const MyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF871A1C)),
            child: Center(
              child: Text(
                'MoveGui',
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            title: MenuItemWidget(
              title: AppLocalizations.of(context)!.home_title,
              route: RouteConstants.HOME_ROUTE,
            ),
          ),
          ListTile(
            title: MenuItemWidget(
              title: AppLocalizations.of(context)!.command_title,
              route: RouteConstants.ORDERS_ROUTE,
            ),
          ),
          ListTile(
            title: MenuItemWidget(
              title: AppLocalizations.of(context)!.delivery_title,
              route: RouteConstants.DELIVERIES_ROUTE,
            ),
          ),
          ListTile(
            title: MenuItemWidget(
              title: AppLocalizations.of(context)!.movegui_title,
              route: RouteConstants.MOVEGUI_ROUTE,
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMenu extends StatelessWidget {
  const SocialMenu({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF871A1C)),
            child: Text(
              'MoveGui',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: MenuItemWidget(
              title: 'Facebook',
              route: 'facebook',
              //      navigatorKey: navigatorKey
            ),
            onTap: () {
              // Handle item tap
            },
          ),
          ListTile(
            title: MenuItemWidget(
              title: 'Instagramm',
              route: 'instagramm',
              //      navigatorKey: navigatorKey,
            ),
            onTap: () {
              // Handle item tap
            },
          ),
        ],
      ),
    );
  }
}

class InfoMenu extends StatelessWidget {
  const InfoMenu({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF871A1C)),
            child: Text(
              'MoveGui',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: MenuItemWidget(
              title: 'Contact',
              route: 'contact',
              //     navigatorKey: navigatorKey,
            ),
            onTap: () {
              // Handle item tap
            },
          ),
          ListTile(
            title: MenuItemWidget(
              title: 'AGB',
              route: 'agb',
              //       navigatorKey: navigatorKey,
            ),
            onTap: () {
              // Handle item tap
            },
          ),
        ],
      ),
    );
  }
}

class UserMenu extends StatelessWidget {
  const UserMenu({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF871A1C)),
            child: Text(
              'MoveGui',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: MenuItemWidget(
              title: 'Se Connecter',
              route: 'connect',
              //       navigatorKey: navigatorKey,
            ),
            onTap: () {
              // Handle item tap
            },
          ),
          ListTile(
            title: MenuItemWidget(
              title: 'Deconnecter',
              route: 'deconnecter',
              //       navigatorKey: navigatorKey,
            ),
            onTap: () {
              // Handle item tap
            },
          ),
          ListTile(
            title: MenuItemWidget(
              title: 'Compte',
              route: 'compte',
              // navigatorKey: navigatorKey,
            ),
            onTap: () {
              // Handle item tap
            },
          ),
        ],
      ),
    );
  }
}
