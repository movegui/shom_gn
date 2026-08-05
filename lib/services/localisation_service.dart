import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shom_gn/models/adress_model.dart';
import 'package:shom_gn/models/geo_cordinates_model.dart';
import 'package:shom_gn/movegui_platform.dart';
import 'package:shom_gn/services/api_service.dart';

import 'package:uuid/uuid.dart';

class LocalisationService {
  final ApiService api;

  LocalisationService({required this.api});
  AdressModel? currentAdress;

  Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // GPS activé ?
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return null;
    }

    if (MoveguiPlatform.getCurrentPlatform() == MoveGuiPlatformEnum.SDK &&
        Platform.isAndroid) {
      final AndroidSettings androidSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        forceLocationManager: false,
      );

      return Geolocator.getCurrentPosition(locationSettings: androidSettings);
    }

    if (MoveguiPlatform.getCurrentPlatform() == MoveGuiPlatformEnum.SDK &&
        Platform.isIOS) {
      final AppleSettings appleSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
      );

      return Geolocator.getCurrentPosition(locationSettings: appleSettings);
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<AdressModel?> getAddressFromPosition(
    double? latitude,
    double? longitude,
    AdressModel? currentAdress
  ) async {

    try {
      if (latitude == null || longitude == null) {
        print('Latitude ou Longitude null');
        return null;
      }
      if (currentAdress != null) {
        if (currentAdress.geoCordinates?.latitude == latitude &&
            currentAdress.geoCordinates?.longitude == longitude) {
          return currentAdress;
        }
      }
      if (kIsWeb) {
        // longitude = -13.648931778824837;
        // latitude = 9.58162511432078;
        final myplace = getAdressFromGeoCordinates(latitude, longitude);
        return myplace ?? AdressModel.getDaulftObject();
      }

      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        final myplace = getAdressFromGeoCordinates(latitude, longitude);
        return myplace ?? AdressModel.getDaulftObject();
      }

      final place = placemarks.first;

      print(place.toJson());

      return AdressModel(
        address: place.street!,
        id: Uuid().v4(),
        name: 'ot_${place.street!}',
        createdAt: DateTime.now(),
        district: place.subLocality!,
        minucipality: place.locality!,
        adressType: 'ot',
        ville: place.administrativeArea,
      );

    } catch (e, stack) {
      print('Geocoding error: $e');
      print(stack);
      return null;
    }
  }

  Future<AdressModel?>? getAdressFromGeoCordinates(
    double latitude,
    double longitude,
  ) async {
    final url =
        '${api.env.baseUrl}/movegui-253e0/us-central1/addressFromGeoCoord'
        '?latitude=$latitude&longitude=$longitude';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final addresses = data['address'].toString().split(',');

      if (addresses.length > 7) {
        final addressModel = AdressModel(
          address: '${addresses[0]} ${addresses[1]}',
          id: Uuid().v4(),
          name: 'ot_${addresses[0]} ${addresses[1]}',
          createdAt: DateTime.now(),
          district: addresses[2],
          minucipality: addresses[3],
          zoneId:
              '${addresses[3]}_${addresses[3]}_${addresses[2]}_${addresses[1]}',
          geoCordinates: GeoCordinatesModel(
            longitude: longitude,
            latitude: latitude,
          ),
          adressType: 'ot',
          ville: addresses[3],
        );
        currentAdress = addressModel;
      }
      print('la place est: ${data.toString()}');
      return currentAdress;
    } else {
      print('il ya eu une erreur');
      print(response.body);
    }

    return null;
  }


double calculateDistance(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  const double earthRadius = 6371; // km

  double dLat = _degToRad(lat2 - lat1);
  double dLon = _degToRad(lon2 - lon1);

  double a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_degToRad(lat1)) *
          cos(_degToRad(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}

double _degToRad(double degree) {
  return degree * pi / 180;
}
}
