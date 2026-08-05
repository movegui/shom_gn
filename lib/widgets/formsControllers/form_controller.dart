

import 'package:shom_gn/models/model.dart';

abstract class FormController<T extends Model> {

  Future<void> setData(T model);
  Future<T> getModel();
}