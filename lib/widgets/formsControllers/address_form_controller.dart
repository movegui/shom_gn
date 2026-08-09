import 'package:flutter/widgets.dart';
import 'package:shom_gn/consts/constants.dart';
import 'package:shom_gn/models/address_model.dart';
import 'package:shom_gn/models/geo_cordinates_model.dart';
import 'package:shom_gn/widgets/formsControllers/form_controller.dart';
import 'package:uuid/uuid.dart';

class AddressFormController extends FormController<AddressModel> {
  final district = TextEditingController();
  final longitude = TextEditingController();
  final latitude = TextEditingController();
  final address = TextEditingController();
  final addressFocusNode = FocusNode();
  final districtFocus = FocusNode();
  final longitudeFocusNode = FocusNode();
  final latitudeFocusNode = FocusNode();
  String? id = Uuid().v4();
  DateTime? createdAt;
  String selectedType = 'h';
  String selectedMunicipality = 'di';
  bool isRegisted = false;
  bool isDefault = false;

  void dispose() {
    district.dispose();
    longitude.dispose();
    latitude.dispose();
    address.dispose();
  }

  void clear() {
    district.clear();
    longitude.clear();
    latitude.clear();
    address.clear();
  }

  @override
  Future<void> setData(AddressModel model) async {
    longitude.text = model.geoCordinates?.longitude?.toString() ?? '';
    latitude.text = model.geoCordinates?.latitude?.toString() ?? '';
    district.text = model.district!;
    address.text = model.address;
    selectedType = model.adressType;
    selectedMunicipality =
        model.minucipality; // getLabelCommune(model.minucipality);
    id = model.id;
    isRegisted = true;
    isDefault = model.isDefault;
  }

  bool isEmpty() {
    return address.text.isEmpty &&
        latitude.text.isEmpty &&
        district.text.isEmpty &&
        longitude.text.isEmpty;
  }

  bool isValid() {
    return address.text.isNotEmpty &&
        latitude.text.isNotEmpty &&
        district.text.isNotEmpty &&
        longitude.text.isNotEmpty;
  }

  @override
  Future<AddressModel> getModel() async => AddressModel(
    address: address.text,
    id: id ?? Uuid().v4(),
    name: '${address.text}_${district.text}_$selectedMunicipality',
    createdAt: createdAt ?? DateTime.now(),
    district: district.text,
    minucipality: selectedMunicipality,
    geoCordinates: GeoCordinatesModel(
      longitude: longitude.text.isNotEmpty ?  double.parse(longitude.text) : null,
      latitude: latitude.text.isNotEmpty ?  double.parse(latitude.text) :null,
    ),
    adressType: selectedType,
    isDefault: isDefault
  );

  String getLabelCommune(String value) {
    switch (value) {
      case COMMUNE_DIXINN:
        return 'di';
      case COMMUNE_GBESSIA:
        return 'gb';
      case COMMUNE_KALOUM:
        return 'ka';
      case COMMUNE_KAGBELEN:
        return 'kg';
      case COMMUNE_KASSA:
        return 'ks';
      case COMMUNE_LAMBANYI:
        return 'la';
      case COMMUNE_MATAM:
        return 'ma';
      case COMMUNE_MANEAH:
        return 'mn';
      case COMMUNE_MATOTO:
        return 'mt';
      case COMMUNE_RATOMA:
        return 'ra';
      case COMMUNE_SONFONIA:
        return 'so';
      case COMMUNE_SANOYAH:
        return 'sn';
      case COMMUNE_TOMBOLIA:
        return 'to';
      default:
        return '';
    }
  }
}
