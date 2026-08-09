import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';
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
      if (!item.enabled) {
        setState(() => _isLoading = true);
        //  final userService = UserService(api: null); // Update with your API instance
        final user = await userService.registerWithFacebook(context);
        if (user != null) {
          // widget.onLoginSuccess?.call();
          context.go(item.routeName!);
        }
      } else {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.deactivate_button_title,
          AppLocalizations.of(context)!.deactivate_button_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }
    } catch (e) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        e.toString(),
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }

    MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
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
          icon: Icon(Ionicons.logo_facebook, size: 24,),
          textStyle: Theme.of(context).textTheme.displayLarge,
        );
  }
}
