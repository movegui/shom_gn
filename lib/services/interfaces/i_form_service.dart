

import 'package:shom_gn/models/model.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/widgets/formsControllers/form_controller.dart';
import 'package:shom_gn/widgets/util/person_form_controller.dart';

abstract class IFormService<M extends Model , F extends FormController<M>> {
  Future<List<UserModel>> getContacts(List<PersonFormController> controllers);
  Future<M> getModel(F controller);
  Future<List<M?>> getModels(List<F> controllers);
  Future<F> getFormController(M? model);
  Future<List<F>> getFormControllers(List<M?> models); 

}
