import 'package:flutter/material.dart';
import 'package:shom_gn/consts/constants.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/l10n/app_localizations.dart';


class CommuneWidgetPicker extends StatefulWidget {
  final String? commune;
  final ValueChanged<String?> onCommuneChange;

  const CommuneWidgetPicker({
    super.key,
    required this.commune,
    required this.onCommuneChange,
  });

  @override
  State<CommuneWidgetPicker> createState() => CommuneWidgetPickerState();
}

class CommuneWidgetPickerState extends State<CommuneWidgetPicker> {
  String? _selectedCommune;

  @override
  void initState() {
    super.initState();
    _selectedCommune = widget.commune;
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
              decoration:  InputDecoration(
                filled: true,
                labelText: AppLocalizations.of(context)!.commune_title,
                labelStyle: TextStyle(fontSize: 12),
                border: InputBorder.none,
              ),
              style: TextStyle( fontSize: 12),
              //   focusColor: AppColors.selectionColor,
              value: _selectedCommune,
              items: [
                DropdownMenuItem(value: 'di', child: Text(COMMUNE_DIXINN)),
                DropdownMenuItem(value: 'gb', child: Text(COMMUNE_GBESSIA)),
                DropdownMenuItem(value: 'ka', child: Text(COMMUNE_KALOUM)),
                DropdownMenuItem(value: 'kg', child: Text(COMMUNE_KAGBELEN)),
                DropdownMenuItem(value: 'ks', child: Text(COMMUNE_KASSA)),
                DropdownMenuItem(value: 'la', child: Text(COMMUNE_LAMBANYI)),
                DropdownMenuItem(value: 'ma', child: Text(COMMUNE_MATAM)),
                DropdownMenuItem(value: 'mn', child: Text(COMMUNE_MANEAH)),
                DropdownMenuItem(value: 'mt', child: Text(COMMUNE_MATOTO)),
                DropdownMenuItem(value: 'ra', child: Text(COMMUNE_RATOMA)),
                DropdownMenuItem(value: 'so', child: Text(COMMUNE_SONFONIA)),
                DropdownMenuItem(value: 'sn', child: Text(COMMUNE_SANOYAH)),
                DropdownMenuItem(value: 'to', child: Text(COMMUNE_TOMBOLIA)),
                DropdownMenuItem(value: '', child: Text('DEFAULT')),
              ],

              onChanged: (value) {
                setState(() => _selectedCommune = value);
                widget.onCommuneChange.call(value);
              },
              validator: (value) {
                return MyValidators.textValidator(value);
              },
            ),

            //   const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String getCommuneLabel(String value){
    switch(value) {
                case 'di': return COMMUNE_DIXINN;
                case 'gb': return COMMUNE_GBESSIA;
                case 'ka': return COMMUNE_KALOUM;
                case 'kg': return COMMUNE_KAGBELEN;
                case 'ks': return COMMUNE_KASSA;
                case 'la': return COMMUNE_LAMBANYI;
                case 'ma': return COMMUNE_MATAM;
                case 'mn': return COMMUNE_MANEAH;
                case 'mt': return COMMUNE_MATOTO;
                case 'ra': return COMMUNE_RATOMA;
                case 'so': return COMMUNE_SONFONIA;
                case 'sn': return COMMUNE_SANOYAH;
                case 'to': return COMMUNE_TOMBOLIA;
                default: return '';
    }
  }
}
