import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/app_constants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/address_model.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/services/form_services/adress_form_service.dart';
import 'package:shom_gn/services/localisation_service.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/seed_service.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/address/address_widget.dart';
import 'package:shom_gn/widgets/address/default_store_or_position_address_widget.dart';
import 'package:shom_gn/widgets/address/display_adress_widget.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';
import 'package:shom_gn/widgets/formsControllers/address_form_controller.dart';
import 'package:shom_gn/widgets/util/btn_register_cancel_widget.dart';
import 'package:shom_gn/widgets/util/button_widget.dart';


class DisplayAdressesWidget extends ConsumerStatefulWidget {
  final AddressModel? storeAddress;
  final AddressModel? currentAddress;
  final List<AddressModel?>? addresses;
  final String? storeSelectionTitle;
  final void Function(bool? value, String? selectedId) onChange;
  final void Function(bool? value, String? selectedId) onStoreSelection;
  final void Function(bool? value, String? selectedId) onCurrentPositionSelection;
  final String? storeName;

  const DisplayAdressesWidget({
    super.key,
    required this.addresses,
    required this.onChange,
    required this.storeAddress,
    required this.onStoreSelection,
    required this.onCurrentPositionSelection,
    required this.currentAddress,
    this.storeSelectionTitle,
    this.storeName
  });
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DisplayAdressesWidgetState();

  
}

class DisplayAdressesWidgetState extends ConsumerState<DisplayAdressesWidget> {
  late SeedService seedService;
  bool enabled = false;
  bool isValid = false;
  late UserService userService;
  String adressId = '';
  late AdressFormService adressFormService;
  List<AddressFormController> formControllers = [];
  late LocalisationService localisationService;
 // late AdressService adressService;
  String _defaultAddressId = '';
 // AddressModel? currentAddress = null;
   bool isLoading = true;

  @override
  void initState() {
    super.initState();
    seedService = getIt<SeedService>();
    userService = getIt<UserService>();
    adressFormService = getIt<AdressFormService>();
  //  adressService = getIt<AdressService>();
  //   currentAddress = ref.read(addressProviderState).address;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      formControllers = await adressFormService.getFormControllers(
        widget.addresses ?? [],
      );
      await setDefaultId();
      /*
      setState(() {
         isLoading = true;
         if(widget.currentAddress != null){
          isLoading = false;
         }
      });
      */
    });
  }

  Future<void> setDefaultId() async {
    final addresses = widget.addresses ?? [];
    for (final address in addresses) {
      if (address!.isDefault) {
        setState(() {
          _defaultAddressId = address.id;
        });

        return;
      }
    }
    if (addresses.isNotEmpty) {
      setState(() {
        _defaultAddressId = addresses[0]?.id ?? '';
        addresses[0]?.isDefault = true;
      });
    }
  }

  Future<List<AddressModel?>?> getAddresses() async {
    return await adressFormService.getModels(formControllers);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _cancelFct(BuildContext dialogContext, ButtonInfo item) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        dialogContext,
        AppLocalizations.of(dialogContext)!.deactivate_button_title,
        AppLocalizations.of(dialogContext)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      Navigator.pop(dialogContext);
    }
  }

  Future<void> _registerFct(
    BuildContext dialogContext,
    ButtonInfo item,
    AddressFormController addressForm,
  ) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        dialogContext,
        AppLocalizations.of(dialogContext)!.deactivate_button_title,
        AppLocalizations.of(dialogContext)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      Navigator.pop(dialogContext);
      await addNewAdresse(item, addressForm, _defaultAddressId);
    }
  }

  Future<void> _addAdress(BuildContext dialogContext, ButtonInfo item) async {
    final addressForm = AddressFormController();
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      await showDialog(
        context: dialogContext,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(dialogContext)!.add_new_adress_title,
            ),

            content: SizedBox(
              width: MediaQuery.of(dialogContext).size.width * 0.6,
              child: SingleChildScrollView(
                child: AddressWidget(
                  onCommuneChange: (value) {
                    setState(() {
                      addressForm.selectedMunicipality = value!;
                    });
                  },
                  onAdressTypeChange: (type) {
                    setState(() {
                      addressForm.selectedType = type!;
                    });
                  },
                  addressForm: addressForm,
                  onChange: (value) {},
                  defaultId: _defaultAddressId,
                  onDefaultAdressChange: (value) async {
                    setState(() {
                      addressForm.isDefault = true;
                      _defaultAddressId = addressForm.id ?? '';
                    });
                    await onDefaultChange(value);
                  },
                ),
              ),
            ),

            actions: [
              BtnRegisterCancelWidget(
                actionFCT: ( item) async {
                  _registerFct(dialogContext, item, addressForm);
                },
                cancelFCT: (item) => _cancelFct(dialogContext, item),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> updateAdress(int index) async {
    final addressForm = formControllers[index];
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.add_new_adress_title),

          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: SingleChildScrollView(
              child: AddressWidget(
                onCommuneChange: (value) {
                  setState(() {
                    addressForm.selectedMunicipality = value!;
                  });
                },
                onAdressTypeChange: (type) {
                  setState(() {
                    addressForm.selectedType = type!;
                  });
                },
                addressForm: addressForm,
                onChange: (value) {},
                defaultId: _defaultAddressId,
                onDefaultAdressChange: (value) {
                  setState(() {
                    addressForm.isDefault = true;
                    _defaultAddressId = value!;
                  });
                  widget.onChange.call(true, value);
                },
                toEdit: true,
              ),
            ),
          ),

          actions: [
            BtnRegisterCancelWidget(
              actionFCT: ( item) async {
                widget.onChange.call(true, _defaultAddressId);
                Navigator.pop(context);
              },
              cancelFCT: (item) => _cancelFct(dialogContext, item),
            ),
          ],
        );
      },
    );
  }

  Future<void> addNewAdresse(
    ButtonInfo item,
    AddressFormController adressForm,
    String defaultId,
  ) async {
    if (formControllers.length < AppConstants.MAX_ADRESSES) {
      setState(() {
        formControllers.add(adressForm);
      });
      widget.onChange.call(true, defaultId);
    } else {
      final l10n = AppLocalizations.of(context)!;

      MessageWidget.errorMessage(
        context,
        l10n.max_adress_title,
        l10n.max_adress_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
  }

  Future<void> removeAdress(int index) async {
    AddressFormController? deletedAdress;
    setState(() {
      deletedAdress = formControllers.removeAt(index);
      widget.onChange.call(true, _defaultAddressId);
    });
    if (deletedAdress != null) {
      if (deletedAdress?.id == _defaultAddressId) {
        await setDefaultId();
      }
    }
  }

  Future<void> onDefaultChange(String? value) async {
    setState(() {
      _defaultAddressId = value!;
      for (final elem in formControllers) {
        elem.isDefault = elem.id == value;
      }
    });
    widget.onChange.call(true, value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
   
       if (widget.currentAddress == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
     
    return Column(
      children: [
        SizedBox(height: 4),

        DefaultStoreOrPositionAddressWidget(
          onDefaultChange: (String? value) {
            setState(() {
              _defaultAddressId = value!;
              widget.onCurrentPositionSelection(true, value);
            });
          },
          model: widget.currentAddress,
          defaultId: _defaultAddressId,
          title: AppLocalizations.of(context)!.my_position,
          locationTitle: AppLocalizations.of(context)!.current_position
        ),

        SizedBox(height: 4),

        DefaultStoreOrPositionAddressWidget(
          onDefaultChange: (String? value) {
            setState(() {
              _defaultAddressId = value!;
              widget.onStoreSelection(true, value);
            });
          },
          model: widget.storeAddress,
          defaultId: _defaultAddressId,
          title: widget.storeSelectionTitle,
          locationTitle: widget.storeName,
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: formControllers.length,
          itemBuilder: (context, index) {
            adressId = formControllers[index].id ?? '';
            final formController = formControllers[index];
            return Center(
              child: Container(
                width:
                    Responsive.isDesktop(context)
                        ? size.width * 0.5
                        : double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DisplayAdressWidget(
                  formController: formController,
                  onRemove: () async {
                    await removeAdress(index);
                  },
                  onEdit: () async {
                    await updateAdress(index);
                  },
                  onDefaultChange: (value) async {
                    await onDefaultChange(value);
                  },
                  defaultId: _defaultAddressId,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: WidgetConstants.sepWidget);
          },
        ),
        SizedBox(height: 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child:
                  formControllers.length < AppConstants.MAX_ADRESSES
                      ? ButtonWidget(
                        onPressed: ( item) async {
                          _addAdress(context, item);
                        },
                        buttonItem: ButtonInfo(
                          title: AppLocalizations.of(context)!.btn_add_adress,
                          enabled: true,
                          routeName: '',
                        ),
                        icon: Icons.add,
                      )
                      : SizedBox(),
            ),
          ],
        ),
      ],
    );
  }
}
