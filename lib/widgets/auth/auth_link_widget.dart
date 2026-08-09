import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/widgets/app/app_link.dart';

class AuthLinkWidget extends StatelessWidget {
  final String? email;

  const AuthLinkWidget({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: AppLink(
              info: ButtonInfo(
                title: AppLocalizations.of(
                  context,
                )!.label_login_forget_password,
                enabled: true,
                routeName: RouteConstants.FORGET_PASSWORD_ROUTE,
              ),
              icon: Icon(Ionicons.key_outline),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: WidgetConstants.sepWidgetHeight,
              right: WidgetConstants.sepWidgetHeight,
            ),
            child: AppLink(
              info: ButtonInfo(
                title: AppLocalizations.of(context)!.label_registration,
                enabled: true,
                routeName: RouteConstants.REGISTER_ROUTE,
              ),
              icon: Icon(Ionicons.person),
              
            ),
          ),
        ),
      ],
    );
  }
}
