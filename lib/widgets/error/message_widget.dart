import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/l10n/app_localizations.dart';


class MessageWidget {
  static Future<dynamic> errorMessage(
    BuildContext context,
    String title,
    String message,
    Icon? icon,
    FlushbarPosition flushbarPosition,
  ) {
    return Flushbar(
      title: title, //'Erreur d\'age',
      message: message, // 'Vous devez être âgé d\'au moins 18 ans.',
      icon: icon,
      duration: Duration(seconds: 3),
      flushbarPosition: flushbarPosition, //.TOP,
      messageColor: Theme.of(context).colorScheme.onSecondary,
      backgroundColor: AppColors.error,
    ).show(context);
  }

  static Future<bool?> showConfirmationDialog(
    BuildContext context,
    VoidCallback confirm,
    VoidCallback cancel,
  ) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.dialog_confirm_title),
          content: Text(AppLocalizations.of(context)!.dialog_confirm_message),
          actions: [
            TextButton(
              onPressed: confirm,
              child: Text(AppLocalizations.of(context)!.dialog_btn_yes),
            ),
            ElevatedButton(
              onPressed: cancel,
              child: Text(AppLocalizations.of(context)!.dialog_btn_no),
            ),
          ],
        );
      },
    );
  }
}
