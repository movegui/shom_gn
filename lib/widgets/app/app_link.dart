import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLink extends ConsumerWidget {
  final String? url;
  final ButtonInfo info;
  final Widget? icon;

  const AppLink({super.key, this.url, required this.info, this.icon});

  Future<void> _openLink() async {
    final uri = Uri.parse(url!);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonStyle = Theme.of(context).textButtonTheme.style;
    return InkWell(
      onTap: _openLink,
      child: TextButton.icon(
        onPressed: () async {
          info.routeName != null
              ? {
                  if (!info.enabled)
                    {
                      MessageWidget.errorMessage(
                        context,
                        AppLocalizations.of(context)!.deactivate_button_title,
                        AppLocalizations.of(context)!.deactivate_button_message,
                        Icon(Icons.error, color: AppColors.error),
                        FlushbarPosition.TOP,
                      ),
                    }
                  else
                    {
                      context.push(info.routeName ?? RouteConstants.HOME_ROUTE),
                    },
                }
              : url != null
              ? await _openLink()
              : {};
        },

        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(8.0)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.selectionColor; // hover color
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.selectionColor;
            }
            return buttonStyle?.backgroundColor?.resolve({}) ??
                AppColors.disabled;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.primary;
            }
            return buttonStyle?.foregroundColor?.resolve({}) ??
                AppColors.disabled;
          }),
        ),

        label: Text(
          info.title ?? 'link',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            decoration: TextDecoration.underline,
            color: AppColors.primary,
            fontStyle: FontStyle.italic,
          ),
        ),
        icon: icon,
      ),
    );
  }
}
