import 'package:flutter/material.dart';
import 'package:shom_gn/l10n/app_localizations.dart';

class DefaultAddressWidget extends StatelessWidget {
  const DefaultAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 16),
          SizedBox(width: 4),
          Text(
            AppLocalizations.of(context)!.address_default_title,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
