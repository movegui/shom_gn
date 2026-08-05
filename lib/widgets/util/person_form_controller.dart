import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shom_gn/models/person_model.dart';
import 'package:shom_gn/widgets/formsControllers/address_form_controller.dart';
import 'package:shom_gn/widgets/formsControllers/form_controller.dart';

class PersonFormController extends FormController<PersonModel> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final middleName = TextEditingController();
  final addressesForms = [AddressFormController()];
  final email = TextEditingController();
  final phone = TextEditingController();
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final middleNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  String? gender = 'm';
  DateTime? birthdate;
  File? pickedImage;
  Uint8List? webImage;

  void dispose() {
    firstName.dispose();
    lastName.dispose();
    middleName.dispose();
    for(final addressForm in addressesForms){
      addressForm.dispose();
    }
    email.dispose();
    phone.dispose();
  }

  void clear() {
    firstName.clear();
    lastName.clear();
    middleName.clear();
       for(final addressForm in addressesForms){
      addressForm.clear();
    }
    email.clear();
    phone.clear();
    birthdate = null;
    pickedImage = null;
    webImage = null;
  }

  @override
  Future<void> setData(PersonModel model) async {
    firstName.text = model.firstName;
    lastName.text = model.lastName;
    middleName.text = model.middleName ?? '';
    addressesForms.asMap().entries.map((entry) async {
      final index = entry.key;
      final addressForm = entry.value;
      await addressForm.setData(model.addresses![index]!);
    }).toList();
    email.text = model.email!;
    phone.text = model.phone!;
  }
  
  @override
  Future<PersonModel> getModel() {
    // TODO: implement getModel
    throw UnimplementedError();
  }
}
