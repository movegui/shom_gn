import 'package:flutter/material.dart';
import 'package:shom_gn/consts/validator.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/widgets/address/address_type_picker.dart';
import 'package:shom_gn/widgets/address/commune_widget_picker.dart';
import 'package:shom_gn/widgets/app/separator_widget.dart';
import 'package:shom_gn/widgets/formsControllers/address_form_controller.dart';
import 'package:shom_gn/widgets/input/input_widget.dart';
import 'package:shom_gn/widgets/util/button_widget.dart';


class AddressWidget extends StatefulWidget {
  final AddressFormController addressForm;
  final ValueChanged<String?> onAdressTypeChange;
  final ValueChanged<String?> onCommuneChange;
  final ValueChanged<String?> onDefaultAdressChange;
  final VoidCallback? onUpdateAdresse;
  final VoidCallback? onRemoveAdress;
  final void Function(String) onChange;
  final bool? isFullBorder;
  final String defaultId;
  final bool? toEdit;

  const AddressWidget({
    super.key,
    required this.onCommuneChange,
    required this.onAdressTypeChange,
    this.isFullBorder = false,
    required this.addressForm,
    required this.onChange,
    required this.defaultId,
    required this.onDefaultAdressChange,
    this.onUpdateAdresse,
    this.onRemoveAdress,
    this.toEdit = false
  });

  @override
  State<StatefulWidget> createState() => AddressWidgetState();
}

class AddressWidgetState extends State<AddressWidget> {
  late bool _readOnly = widget.addressForm.isValid() ? widget.toEdit! ? false : true : false;

  @override
  Widget build(BuildContext context) {
    return Column(
      //  key: addAddressKey,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width:
                  Responsive.isDesktop(context)
                      ? 150
                      : MediaQuery.of(context).size.width * 0.3,
              child: AddressTypePicker(
                adresseType: widget.addressForm.selectedType,
                onAdressTypeChange: (type) {
                  setState(() {
                    widget.addressForm.selectedType = type!;
                    widget.onAdressTypeChange.call(type);
                  });
                },
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: widget.addressForm.address,
                focusNode: widget.addressForm.addressFocusNode,
                icon: Icons.home,
                hinterText: AppLocalizations.of(context)!.input_hint_adress,
                isFullBorder: widget.isFullBorder,
                validator: (vaule) {
                  return MyValidators.textNameValidator(vaule);
                },
                onChange: (value) {
                  widget.onChange.call(value);
                },
                readOnly: _readOnly,
                maxLines: 2,
                textInputType: TextInputType.multiline,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width:
                  Responsive.isDesktop(context)
                      ? 150
                      : MediaQuery.of(context).size.width * 0.3,
              child: CommuneWidgetPicker(
                commune: widget.addressForm.selectedMunicipality,
                onCommuneChange: (value) {
                  widget.addressForm.selectedMunicipality = value!;
                  widget.onCommuneChange.call(value);
                },
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: widget.addressForm.district,
                focusNode: widget.addressForm.districtFocus,
                icon: Icons.home,
                hinterText: AppLocalizations.of(context)!.input_hint_quartier,
                isFullBorder: widget.isFullBorder,
                validator: (vaule) {
                  return MyValidators.textNameValidator(vaule);
                },
                onChange: (value) {
                  widget.onChange(value);
                },
                readOnly: _readOnly,
                maxLines: 2,
                textInputType: TextInputType.multiline,
              ),
            ),
          ],
        ),
        standardAdresseWidget(),
        widget.addressForm.isValid() && !widget.toEdit!
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: updateButtonWidget()),
                SizedBox(width: WidgetConstants.sepWidgetHeight),
                Expanded(child: removeButtonWidget()),
              ],
            )
            : SizedBox(),
        SeparatorWidget(height: 6),
      ],
    );
  }

  Widget updateButtonWidget() {
    return ButtonWidget(
      onPressed: (item) async {
        setState(() {
          _readOnly = false;
        });
        widget.onUpdateAdresse?.call();
      },
      buttonItem: ButtonInfo(
        title: AppLocalizations.of(context)!.btn_update_adress,
        enabled: widget.addressForm.isValid(),
        routeName: '',
      ),
      icon: Icons.edit,
    );
  }

  Widget standardAdresseWidget() {
    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.standard_address,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Radio<String>(
            value: widget.addressForm.id!,
            groupValue: widget.defaultId,
            onChanged: (value) {
              widget.onDefaultAdressChange.call(value);
            },
          ),
        ),
      ],
    );
  }

  Widget removeButtonWidget() {
    return ButtonWidget(
      onPressed: (item) async {
        widget.onRemoveAdress?.call();
      },
      buttonItem: ButtonInfo(
        title: AppLocalizations.of(context)!.btn_delete,
        enabled: widget.addressForm.isValid(),
        routeName: '',
      ),
      icon: Icons.delete,
      //  textColor: Colors.red,
    );
  }
}
