
import 'package:shom_gn/models/order_item_model.dart';
import 'package:shom_gn/models/order_model.dart';
import 'package:shom_gn/models/store_model.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/services/form_services/form_service.dart';
import 'package:shom_gn/widgets/formsControllers/form_controller.dart';
import 'package:shom_gn/widgets/formsControllers/order_form_controller.dart';

abstract class OrderFormService<  M extends StoreModel,
  U extends UserModel,
  I extends OrderItemModel,
  OM extends OrderModel<U, I>,
  F extends FormController<M>,
  FS extends FormService<M,F> , O extends OrderFormController<M,U,I,OM,F,FS>>  extends FormService<M, F> {
  OrderFormService({required super.api});


}