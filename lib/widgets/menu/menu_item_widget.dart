import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({super.key, required this.title, required this.route});
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(route);
      },
      child: Card(
        // color: Color(0xFF871A1C),
        margin: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(color: AppColors.primary),
            ),
          ),
        ),
      ),
    );
  }
}

class HoverListTile extends StatefulWidget {
  const HoverListTile({
    super.key,
    required this.icon,
    required this.item,
    this.onTap,
    this.color = AppColors.primary,
  });

  final IconData icon;
  final ButtonInfo item;
  final VoidCallback? onTap;
  final Color? color;

  @override
  State<HoverListTile> createState() => _HoverListTileState();
}

class _HoverListTileState extends State<HoverListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: ListTile(
        leading: Icon(
          widget.icon,
          color: widget.item.enabled
              ? isHovered
                    ? AppColors.onPrimary
                    : widget.color
              : AppColors.disabled,
        ),
        title: Text(
          widget.item.title ?? "Shom_GN",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: widget.item.enabled
                ? isHovered
                      ? AppColors.onPrimary
                      : widget.color
                : AppColors.disabled,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        tileColor: widget.item.enabled
            ? isHovered
                  ? AppColors.selectionColor
                  : Colors.transparent
            : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap:
            widget.onTap ??
            () {
              if (widget.item.enabled) {
                context.push(
                  widget.item.routeName ?? RouteConstants.HOME_ROUTE,
                );
              } else {
                notImplemented();
              }
            },
      ),
    );
  }

  Future<dynamic> notImplemented() {
    return MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }
}
