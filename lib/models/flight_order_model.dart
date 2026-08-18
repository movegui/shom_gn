import 'package:shom_gn/models/flight_order_item_model.dart';
import 'package:shom_gn/models/order_model.dart';
import 'package:shom_gn/models/user_model.dart';

class FlightOrderModel extends OrderModel<UserModel,FlightOrderItemModel> {
  FlightOrderModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.user,
    required super.total,
    required super.items,
    required super.status,
    required super.currency,
    required super.orderId,
  });
}
