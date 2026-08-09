import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/l10n/app_localizations.dart';


class AppFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double iconSize;

  const AppFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    return BottomNavigationBar(
      backgroundColor: theme.colorScheme.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.selectionColor,
      unselectedItemColor: AppColors.disabled,
      items: [
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.home_title,
          icon:Icon(Icons.home, size: iconSize,),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.search_flight_title,
          icon: Icon(Icons.flight_takeoff, size: iconSize,)
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.my_reservation_title,
          icon: Icon(Icons.confirmation_number_outlined, size: iconSize,),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.profile_title,
          icon: Icon(Icons.person_outline , size: iconSize,),
        ),
      ],
    );
  }
}
