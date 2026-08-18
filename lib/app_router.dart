import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/opt_args_model.dart';
import 'package:shom_gn/providers/auth_provider.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/screens/auth/forgot_password_screen.dart';
import 'package:shom_gn/screens/auth/login_screen.dart';
import 'package:shom_gn/screens/auth/otp_verification_screen.dart';
import 'package:shom_gn/screens/auth/register_screen.dart';
import 'package:shom_gn/screens/home_screen.dart';
import 'package:shom_gn/screens/notification_screen.dart';
import 'package:shom_gn/screens/profile/movegui_profile_screen.dart';
import 'package:shom_gn/screens/profile/account_screen.dart';
import 'package:shom_gn/screens/search_screen.dart';
import 'package:shom_gn/screens/shopping_cart_screen.dart';
import 'package:shom_gn/widgets/app/app_footer.dart';
import 'package:shom_gn/widgets/app/app_route_observer.dart';
import 'package:shom_gn/widgets/web/app_footer_web.dart';
import 'package:shom_gn/widgets/app/app_appbar.dart';
import 'package:shom_gn/widgets/menu/my_menu.dart';
import 'package:shom_gn/widgets/web/web_appbar.dart';

class AppRouter {
  static const double iconSize = 18.0;
  static final routerProvider = Provider<GoRouter>((ref) {
    final authAsync = ref.watch(authStateProvider);
    String title = '';
    return GoRouter(
      initialLocation: RouteConstants.SPLASH_ROUTE,
      observers: [AppRouteObserver.instance],
      refreshListenable: GoRouterRefreshStream(
        FirebaseAuth.instance.authStateChanges(),
      ),
      redirect: (context, state) {
        title = getTitleHome(state.uri.toString(), context);
        if (authAsync.isLoading) {
          return RouteConstants.SPLASH_ROUTE; // ✅ DO NOTHING
        }
        final user = authAsync.value;
        final isAuthRoute =
            state.matchedLocation == RouteConstants.LOGIN_ROUTE ||
            state.matchedLocation == RouteConstants.REGISTER_ROUTE ||
            state.matchedLocation == RouteConstants.FORGET_PASSWORD_ROUTE ||
            state.matchedLocation == RouteConstants.OTP_SCREEN_ROUTE;

        final isSplash = state.matchedLocation == RouteConstants.SPLASH_ROUTE;

        if (user == null && !isAuthRoute) {
          return RouteConstants.LOGIN_ROUTE;
        }

        if (user != null && (isAuthRoute || isSplash)) {
          return RouteConstants.HOME_ROUTE;
        }
        return null;
      },

      routes: [
        GoRoute(
          path: RouteConstants.SPLASH_ROUTE,
          builder: (_, __) => const Center(child: CircularProgressIndicator()),
        ),
        GoRoute(
          path: RouteConstants.LOGIN_ROUTE,
          builder: (context, state) => LoginScreen(),
        ),

        GoRoute(
          path: RouteConstants.FORGET_PASSWORD_ROUTE,
          builder: (context, state) => ForgotPasswordScreen(),
        ),
        GoRoute(
          path: RouteConstants.REGISTER_ROUTE,
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: RouteConstants.OTP_SCREEN_ROUTE,
          builder: (context, state) {
            final args = state.extra as OptArgsModel;
            return OtpVerificationScreen(
              verificationId: args.verificationId,
              currentUser: args.currentUser!,
              confirmationResult: args.confirmationResult,
            );
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return Consumer(
              builder: (context, ref, _) {
                title = getTitle(state.uri.toString(), context, ref);
                if (title.isEmpty) {
                  title = getTitleFromChild(child, context, ref);
                }
                //      ref.read(appbarTitleProviderState).setTitle(title);
                final int currentIndex = getIndexFromLocation(
                  state.matchedLocation,
                );
                return Scaffold(
                  appBar: Responsive.isDesktop(context)
                      ? WebAppBar(title: title)
                      : AppAppbar(
                          itemCount: ref.watch(shoppingProviderState).itemCount,
                          title: title,
                        ),
                  drawer: Responsive.isMobile(context) ? MyMenu() : null,
                  body: child,
                  bottomNavigationBar: Responsive.isDesktop(context)
                      ? AppFooterWeb()
                      : AppFooter(
                          currentIndex: currentIndex,
                          iconSize: iconSize,
                          onTap: (index) => context.go(routeForIndex(index)),
                        ),
                );
              },
            );
          },

          routes: [
            GoRoute(
              path: RouteConstants.HOME_ROUTE,
              builder: (context, state) => const HomeScreen(),
              routes: [],
            ),

            GoRoute(
              path: RouteConstants.PROFILE_ROUTE,
              builder: (context, state) =>
                  const Center(child: MyProfileScreen()),
              routes: [
                GoRoute(
                  path: '${RouteConstants.ACCOUNT_ROUTE}/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return AccountScreen(id: id);
                  },
                ),
              ],
            ),
            GoRoute(
              path: RouteConstants.NOTIFICATIONS_ROUTE,
              builder: (context, state) => NotificationScreen(),
              routes: [],
            ),
            GoRoute(
              path: RouteConstants.SHOPPING_ROUTE,
              builder: (context, state) => ShoppingCartScreen(),
              routes: [],
            ),
            GoRoute(
              path: RouteConstants.SEARCH_ROUTE,
              builder: (context, state) => SearchScreen(),
            )
          ],
        ),
      ],
    );
  });

  static String getTitle(
    String routeName,
    BuildContext context,
    WidgetRef ref,
  ) {
    if (routeName.startsWith(RouteConstants.PROFILE_ROUTE)) {
      return AppLocalizations.of(context)!.profile_title;
    }

    if (routeName.startsWith(RouteConstants.ORDERS_ROUTE)) {
      return AppLocalizations.of(context)!.my_orders_title;
    }

    if (routeName.startsWith(RouteConstants.HOME_ROUTE)) {
      return AppLocalizations.of(context)!.home_title;
    }

    if (routeName.startsWith(RouteConstants.LOGIN_ROUTE)) {
      return AppLocalizations.of(context)!.home_title;
    }

    if (routeName.startsWith(RouteConstants.REGISTER_ROUTE)) {
      return AppLocalizations.of(context)!.home_title;
    }
    if(routeName.startsWith(RouteConstants.SHOPPING_ROUTE)) {
      return AppLocalizations.of(context)!.my_trips;
    }
       if(routeName.startsWith(RouteConstants.SEARCH_ROUTE)) {
      return AppLocalizations.of(context)!.search;
    }

    return '';
  }

  static String getTitleHome(String routeName, BuildContext context) {
    if (routeName.startsWith(RouteConstants.HOME_ROUTE)) {
      return AppLocalizations.of(context)!.home_title;
    }

    if (routeName.startsWith(RouteConstants.LOGIN_ROUTE)) {
      return AppLocalizations.of(context)!.home_title;
    }

    if (routeName.startsWith(RouteConstants.REGISTER_ROUTE)) {
      return AppLocalizations.of(context)!.home_title;
    }

    if (routeName.startsWith(RouteConstants.OTP_SCREEN_ROUTE)) {
      return AppLocalizations.of(context)!.home_title;
    }

    if (routeName.startsWith(RouteConstants.FORGET_PASSWORD_ROUTE)) {
      return AppLocalizations.of(context)!.home_title;
    }

    return '';
  }

  static int getIndexFromLocation(String routeName) {
    if (routeName.startsWith(RouteConstants.HOME_ROUTE)) return 0;
    if (routeName.startsWith(RouteConstants.ORDERS_ROUTE)) return 1;
    if (routeName.startsWith(RouteConstants.PROFILE_ROUTE)) return 3;
    return 0;
  }

  static String routeForIndex(int index) {
    switch (index) {
      case 0:
        return RouteConstants.HOME_ROUTE;
      case 1:
        return RouteConstants.ORDERS_ROUTE;
      case 3:
        return RouteConstants.PROFILE_ROUTE;
      default:
        return RouteConstants.HOME_ROUTE;
    }
  }

  static String getTitleFromChild(
    Widget child,
    BuildContext context,
    WidgetRef ref,
  ) {
    // handle common wrappers (Center, Padding, etc.)
    Widget target = child;
    if (child is Center) {
      target = child.child ?? child;
    }

    final type = target.runtimeType.toString();
    if (type.contains('HomeScreen')) {
      return AppLocalizations.of(context)!.home_title;
    }
    if (type.contains('PressingScreen')) {
      return AppLocalizations.of(context)!.pressing_title;
    }
    if (type.contains('MoveguiProfileScreen')) {
      return AppLocalizations.of(context)!.profile_title;
    }
    if (type.contains('OrderScreen')) {
      return AppLocalizations.of(context)!.my_orders_title;
    }
    if (type.contains('DeliveryScreen')) {
      return AppLocalizations.of(context)!.my_deliveries_title;
    }
    return '';
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
