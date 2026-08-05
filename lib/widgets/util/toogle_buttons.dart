import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/responsive.dart';

class ToggleButtonExample extends StatefulWidget {
  const ToggleButtonExample({super.key, required this.onStateChanged});

  final Function(int) onStateChanged;

  @override
  _ToggleButtonExampleState createState() => _ToggleButtonExampleState();
}

class _ToggleButtonExampleState extends State<ToggleButtonExample> {
  List<bool> isSelected = [true, false];
  int _selectedIndex = 0;
  final bool _isHoveringEmailText = false;
  final bool _isHoveringPhoneText = false;
  late Color backgroundColor;

  @override
  void initState() {
    backgroundColor = AppColors.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(24),
        fillColor: Theme.of(context).colorScheme.primary, // 👈 selected background
        selectedColor: AppColors.selectionColor, // text/icon when selected
        color: AppColors.disabled, // text/icon when not selected
        isSelected: [_selectedIndex == 0, _selectedIndex == 1],
        onPressed: (int index) {
          setState(() {
            _selectedIndex = index;
            widget.onStateChanged(index);
          });
        },
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: WidgetConstants.sepWidgetWidth * 0.3,
                ),
                child: Icon(
                  Icons.phone,
                  size: WidgetConstants.buttonFonsize * 1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: WidgetConstants.sepWidgetWidth * 0.3,
                ),
                child: Text(
                  AppLocalizations.of(context)!.company_label_phone,
                  style: TextStyle(
                    fontSize:Responsive.isMobile(context) ? WidgetConstants.buttonFonsize * 1.5 : WidgetConstants.buttonFonsize * 2.5,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: WidgetConstants.sepWidgetWidth * 0.3,
                ),
                child: Icon(
                  IconlyLight.message,
                  size: WidgetConstants.buttonFonsize * 1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: WidgetConstants.sepWidgetWidth * 0.3,
                  left: WidgetConstants.sepWidgetWidth * 0.6,
                ),
                child: Text(
                  AppLocalizations.of(context)!.company_label_email,
                  style: TextStyle(
                    fontSize:Responsive.isMobile(context) ? WidgetConstants.buttonFonsize * 1.5 : WidgetConstants.buttonFonsize * 2.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
