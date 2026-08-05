import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/models/pressing/pressing_order_item.dart';
import 'package:movegui/models/pressing/pressing_order_model.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/services/form_services/pressing_form_service.dart';
import 'package:movegui/widgets/formsControllers/order_form_controller.dart';
import 'package:movegui/widgets/formsControllers/pressing_form_controller.dart';

class PressingOrderFormController
    extends
        OrderFormController<
          PressingModel,
          UserModel,
          PressingOrderItem,
          PressingOrderModel,
          PressingFormController,
          PressingFormService
        > {
  PressingOrderFormController({required super.order,});
  
  @override
  Future<PressingOrderModel> getModel() {
    // TODO: implement getModel
    throw UnimplementedError();
  }
  
  @override
  Future<void> setData(PressingOrderModel model) {
    // TODO: implement setData
    throw UnimplementedError();
  }

 
}
