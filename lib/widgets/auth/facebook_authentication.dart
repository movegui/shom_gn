import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/services/my_app_functions.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/util/button_widget.dart';

class FacebookAuthentication extends StatefulWidget {
  const FacebookAuthentication({super.key});

  @override
  State<FacebookAuthentication> createState() => FacebookAuthenticationState();
}

class FacebookAuthenticationState extends State<FacebookAuthentication> {
  bool _isLoading = false;
  late UserService userService;

  @override
  initState() {
    super.initState();
    userService = getIt<UserService>();
  }

  Future<void> _onPressed(BuildContext context, ButtonInfo item) async {
    try {
      setState(() => _isLoading = true);
      final user = await userService.registerWithFacebook(context);
      if (user != null) {
        context.go(item.routeName!);
      }
    } catch (e) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: e.toString(),
        fct: () {},
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : ButtonWidget(
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.label_login_facebook,
              enabled: false,
              routeName: RouteConstants.HOME_ROUTE,
            ),
            onPressed: (buttonItem) async {
              await _onPressed(context, buttonItem);
            },
            icon: Icon(Ionicons.logo_facebook, size: 24),
            textStyle: Theme.of(context).textTheme.displayLarge,
          );
  }
}
