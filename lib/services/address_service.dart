import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shom_gn/models/address_model.dart';
import 'package:shom_gn/models/geo_cordinates_model.dart';
import 'package:shom_gn/services/api_service.dart';
import 'package:shom_gn/services/localisation_service.dart';
import 'package:shom_gn/services/register_services.dart';

class AddressService {
  final ApiService api;

  AddressService({required this.api});
  final locationService = getIt<LocalisationService>();

  Future<GeoCordinatesModel?> getCoordinates(String address) async {
    final url =
        '${api.env.baseUrl}/movegui-253e0/us-central1/geocodeAddress'
        '?address=${Uri.encodeComponent(address)}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return GeoCordinatesModel(
        longitude: data['longitude'],
        latitude: data['latitude'],
      );
    }

    return null;
  }

  Future<AddressModel?>? getCurrentAddress(AddressModel? currentAddress) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    const settings = LocationSettings(accuracy: LocationAccuracy.high);

    final position = await locationService.getCurrentPosition();

    /*
    await Geolocator.getCurrentPosition(
      locationSettings: settings,
    );
    */

    final place = await locationService.getAddressFromPosition(
      position?.latitude,
      position?.longitude,
      currentAddress
    );
    print('the place is: $place');
    return place;

  }


}
