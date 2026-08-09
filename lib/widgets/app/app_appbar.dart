import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/widgets/app/app_route_observer.dart';

class AppAppbar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const AppAppbar({ required this.title, super.key, this.itemCount});
  final int? itemCount;
   final String title ;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AppAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppAppbarState extends ConsumerState<AppAppbar>  {


  @override
  Widget build(BuildContext context) {
 //   title = ref.watch(appbarTitleProviderState).title;
    final buttonStyle = Theme.of(context).iconButtonTheme.style;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Center(
        child: Text(widget.title, style: Theme.of(context).textTheme.headlineMedium),
      ),
      titleTextStyle: TextStyle(fontSize: 20),
      leading: Builder(
        builder: (context) {
          final canPop = context.canPop() || false;
          if (canPop) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            );
          }

          final scaffold = Scaffold.maybeOf(context);
          final hasDrawer = scaffold?.widget.drawer != null;
          if (hasDrawer) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
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
          style: buttonStyle,
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              onPressed: () {
                context.push(RouteConstants.SHOPPING_ROUTE);
              },
              style: buttonStyle,
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Text(
                  '${widget.itemCount}',
                  style: const TextStyle(fontSize: 10),
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
          style: buttonStyle,
        ),
      ],
    );
  }

  String getTitle(String routeName, BuildContext context) {
    return switch (routeName) {
      RouteConstants.LOGIN_ROUTE => AppLocalizations.of(context)!.login_title,

      RouteConstants.FORGET_PASSWORD_ROUTE => AppLocalizations.of(
        context,
      )!.forget_password_title,

      RouteConstants.REGISTER_ROUTE => AppLocalizations.of(
        context,
      )!.register_title,
      _ => '',
    };
  }
}
