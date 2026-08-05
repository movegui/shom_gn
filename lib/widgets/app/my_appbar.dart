import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/providers/providers.dart';



class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.itemCount});
  final int? itemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(appbarTitleProviderState).title;
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle( fontSize: 20),
      leading: Builder(
        builder: (context) {
          final canPop = context.canPop() || false;
          if (canPop) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            );
          }

          final scaffold = Scaffold.maybeOf(context);
          final hasDrawer = scaffold?.widget.drawer != null;
          if (hasDrawer) {
            return IconButton(
              icon: const Icon(Icons.menu),
              tooltip: AppLocalizations.of(context)!.navigation_menu_tooltip,
              onPressed: () => scaffold?.openDrawer(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            context.push(RouteConstants.SEARCH_ROUTE);
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              onPressed: () {
                context.push(RouteConstants.SHOPPING_ROUTE);
              },
            ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$itemCount',
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            context.push(RouteConstants.NOTIFICATIONS_ROUTE);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
