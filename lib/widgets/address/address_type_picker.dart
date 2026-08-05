import 'package:flutter/material.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/l10n/app_localizations.dart';


class AddressTypePicker extends StatefulWidget {
  final String? adresseType;
  final ValueChanged<String?> onAdressTypeChange;

  const AddressTypePicker({
    super.key,
    required this.adresseType,
    required this.onAdressTypeChange,
  });

  @override
  State<AddressTypePicker> createState() => AddressTypePickerState();
}

class AddressTypePickerState extends State<AddressTypePicker> {
  String? _selectedAdressType;

  @override
  void initState() {
    super.initState();
    _selectedAdressType = widget.adresseType;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  const SizedBox(height: 12),
            // Gender dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                labelText: AppLocalizations.of(context)!.input_hint_adress,
                labelStyle: TextStyle( fontSize: 12),
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 12),

              value: _selectedAdressType,
              items: [
                DropdownMenuItem(
                  value: 'h',
                  child: Text(AppLocalizations.of(context)!.address_home_title),
                ),
                DropdownMenuItem(
                  value: 'o',
                  child: Text(
                    AppLocalizations.of(context)!.address_office_title,
                  ),
                ),
                DropdownMenuItem(
                  value: 'n',
                  child: Text(
                    AppLocalizations.of(context)!.address_neighbor_title,
                  ),
                ),
                DropdownMenuItem(
                  value: 'ot',
                  child: Text(
                    AppLocalizations.of(context)!.address_other_title,
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() => _selectedAdressType = value);
                widget.onAdressTypeChange.call(value);
              },
              validator: (value) {
                MyValidators.textValidator(value);
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  String getAddressTypeLabel(String value) {
    switch (value) {
      case 'h':
        return AppLocalizations.of(context)!.address_home_title;
      case 'o':
        return AppLocalizations.of(context)!.address_office_title;
      case 'n':
        return AppLocalizations.of(context)!.address_neighbor_title;
      case 'ot':
        return AppLocalizations.of(context)!.address_other_title;
      default:
        return '';
    }
  }
}
