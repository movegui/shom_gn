import 'package:flutter/material.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/widgets/auth/validation_button.dart';


class BtnRegisterCancelWidget extends StatelessWidget {
  final Future<void> Function(ButtonInfo item) actionFCT;
  final Future<void> Function(ButtonInfo item) cancelFCT;
  final String? actionTitle;
  final IconData? icon;
  final String? actionRouteName;
  final String? cancelRouteName;
  final bool? actionEnabled;

  const BtnRegisterCancelWidget({super.key, 
    required this.actionFCT,
    required this.cancelFCT,
     this.actionTitle,
     this.icon = Icons.save,
     this.actionRouteName = '',
     this.cancelRouteName = '',
     this.actionEnabled = true

  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValidationButton(
            fn: actionFCT,
            buttonItem: ButtonInfo(
              title:
                  actionTitle ??
                  AppLocalizations.of(context)!.btn_register_label,
              enabled: actionEnabled ??  true,
              routeName: actionRouteName ?? '',
            ),
            icon: icon,
          ),
        ),
        SizedBox(width: WidgetConstants.sepWidgetHeight),
        Expanded(
          child: ValidationButton(
            fn: cancelFCT,
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.btn_cancel,
              enabled: true,
              routeName: '',
            ),
            icon: Icons.cancel_outlined,
          ),
        ),
      ],
    );
  }
}
