import 'package:flutter/material.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/widgets/input/input_widget.dart';



class InputAdressWidget extends StatelessWidget {

  final TextEditingController adressController;
  final FocusNode adressFocusNode;
  final FocusNode? nextFocusNode;

  const InputAdressWidget({
    super.key,
    required this.adressController,
    required this.adressFocusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: adressController,
      focusNode: adressFocusNode,
      icon: Icons.home,
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.streetAddress,
      hinterText: AppLocalizations.of(context)!.input_hint_adress,
      validator: (value) {
        return MyValidators.textNameValidator(value);
      },
    );
  }

}