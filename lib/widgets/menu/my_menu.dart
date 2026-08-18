import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/widgets/menu/menu_item_widget.dart';

class MyMenu extends ConsumerWidget {
  const MyMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProviderState).user;
    if (currentUser == null) {
      return const SizedBox.shrink();
    }

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 28, child: Icon(Icons.person, size: 30)),
                  SizedBox(height: 12),
                  Text(
                    currentUser.personModel!.name.isEmpty
                        ? "No Name"
                        : "Shom_GN",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    currentUser.personModel?.email ?? "shom_gn@email.com",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  HoverListTile(
                    icon: Icons.home_outlined,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.home_title,
                      enabled: true,
                      routeName: RouteConstants.HOME_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.flight_takeoff,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.search_flight_title,
                      enabled: true,
                      routeName: RouteConstants.SEARCH_FLIGHT_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.hotel_outlined,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.hotels_title,
                      enabled: false,
                      routeName: RouteConstants.SEARCH_HOTEL_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.book_online_outlined,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.my_trips,
                      enabled: false,
                      routeName: RouteConstants.SEARCH_MY_TRIPS_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.favorite_border,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.favoris_title,
                      enabled: false,
                      routeName: RouteConstants.FAVORITES_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.shopping_cart_outlined,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.shopping_cart_title,
                      enabled: false,
                      routeName: RouteConstants.FAVORITES_ROUTE,
                    ),
                  ),

                  const Divider(),

                  HoverListTile(
                    icon: Icons.person_outline,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.my_profile_title,
                      enabled: false,
                      routeName: RouteConstants.PROFILE_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.notifications_none,
                    item: ButtonInfo(
                      title: AppLocalizations.of(
                        context,
                      )!.profile_menu_notification,
                      enabled: false,
                      routeName: RouteConstants.NOTIFICATIONS_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.language_outlined,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.language_title,
                      enabled: false,
                      routeName: RouteConstants.NOTIFICATIONS_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.help_outline,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.help_title,
                      enabled: false,
                      routeName: RouteConstants.HELP_ROUTE,
                    ),
                  ),

                  HoverListTile(
                    icon: Icons.settings_outlined,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.settings_title,
                      enabled: false,
                      routeName: RouteConstants.SETTINGS_ROUTE,
                    ),
                  ),

                  const Divider(),

                  HoverListTile(
                    icon: Icons.logout,
                    item: ButtonInfo(
                      title: AppLocalizations.of(context)!.profile_menu_logout,
                      enabled: true,
                      routeName: '',
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    color: AppColors.error,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primary),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
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
