import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shom_gn/models/address_model.dart';
import 'package:shom_gn/models/model.dart';
import 'package:shom_gn/models/service_model.dart';
import 'package:shom_gn/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

abstract class ModelService<T extends Model> {
  final ApiService api;

  ModelService({required this.api});
  Future<T> addModel(T model);
  Future<List<T>> allModels();
  Future<List<T>> getByName(String name);
  String getCollectionName();
  Future<T> getModelById(String id);

  Future<void> callNumber(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $uri');
    }
  }

  String getCureency() {
    return api.currency;
  }

  Future<double> getTotal(List<ServiceModel> services, List<int> qtys) async {
    double sum = 0;
    for (var i = 0; i < services.length; i++) {
      final service = services[i];
      final qty = i < qtys.length ? qtys[i] : 0;
      final pricePerUnit = (service.basePrice ?? 0);
      sum += (pricePerUnit * qty);
    }
    return sum;
  }

  Future<AddressModel> addAdress(String id, AddressModel adress) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .collection(AddressModel.getCollectionName())
        .doc(adress.id)
        .set(adress.toJson());

    return adress;
  }

  Future<AddressModel> updateAddress(String userId, AddressModel address) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(userId)
        .collection(AddressModel.getCollectionName())
        .doc(address.id)
        .set(address.toJson(), SetOptions(merge: true));

    return address;
  }

  Future<void> updateAddresses(
    String userId,
    List<AddressModel?>? addresses,
  ) async {
    for (final address in addresses!) {
      await updateAddress(userId, address!);
    }
  }

  Future<Map<String, dynamic>> loadConfig() async {
  final jsonString = await rootBundle.loadString('assets/config/info.json');
  return json.decode(jsonString);
}

Future<String> generateOrderNumber(String name) async {
  final firestore = FirebaseFirestore.instance;
    final now = DateTime.now();
      return 'PRS-''$name'
        '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}-'
        '${0.toString().padLeft(4, '0')}';
}

}
