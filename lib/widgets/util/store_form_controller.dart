import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movegui/models/adress_model.dart';
import 'package:movegui/models/categories_model.dart';
import 'package:movegui/models/open_hours_model.dart';
import 'package:movegui/models/store/store_model.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/widgets/formsControllers/address_form_controller.dart';
import 'package:movegui/widgets/formsControllers/form_controller.dart';
import 'package:movegui/widgets/util/person_form_controller.dart';

abstract class StoreFormController<T extends StoreModel>
    extends FormController<T> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final description = TextEditingController();
  final nameFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final emailFocus = FocusNode();
  final telephonFocus = FocusNode();
  final addressForm = AddressFormController();
  final personForms = [PersonFormController()];
  List<UserModel> contacts = [];
  List<OpenHoursModel> weeklyHours = [];
  File? pickedImage;
  Uint8List? webImage;
  StoreTypeModel? selectedType;
  CategoriesModel? categoriesModel;
  AdressModel? adressModel;

  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    description.dispose();
    addressForm.dispose();
  }

  void clear() {
    name.clear();
    description.clear();
    phone.clear();
    email.clear();
    addressForm.clear();
    pickedImage = null;
    webImage = null;
    for (final personForm in personForms) {
   //   personForm.clear();
    }
    /*
    personForms.map((personForm) {
       personForm.clear();
    });
    */
    contacts.clear();
    weeklyHours.clear();
    selectedType = null;
    categoriesModel = null;
    adressModel = null;
  }

  @override
  Future<void> setData(T model) async {
    name.text = model.name;
    phone.text = model.phone;
    email.text = model.email;
    description.text = model.description;
    await addressForm.setData(model.address);
    await Future.wait(
      personForms.asMap().entries.map((entry) async {
        final index = entry.key;
        final personForm = entry.value;
      //  await personForm.setData(model.staff[index].personModel!);
      }),
    );
  }
}


