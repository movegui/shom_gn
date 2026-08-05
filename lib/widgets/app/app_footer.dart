import 'package:flutter/material.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/services/assets_manager.dart';


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
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.home_title,
          icon:Icon(Icons.home, size: iconSize,),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.command_title,
          icon: ImageIcon(
            AssetImage(AssetsManager.commandeIcon3), 
            size: iconSize,
          ),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.delivery_title,
          icon: ImageIcon(
            AssetImage(AssetsManager.livraisonIcon3),
            size: iconSize,
          ),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.profile_title,
          icon: ImageIcon(
            AssetImage(AssetsManager.reservationIcon3),
            size: iconSize,
          ),
        ),
      ],
    );
  }
}
