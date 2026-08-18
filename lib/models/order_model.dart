

import 'package:shom_gn/models/model.dart';
import 'package:shom_gn/models/order_item_model.dart';
import 'package:shom_gn/models/user_model.dart';

abstract class OrderModel<M extends UserModel , T extends OrderItemModel> extends Model {
  final M user;
   List<T> items;
   double total;
   String status;
  final String currency;
  String orderId;
  OrderModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.user,
    required this.total,
    required this.items,
    required this.status,
    required this.currency,
    required this.orderId
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'user': user.toJson(),
    'items': items.map((item) => item.toJson()).toList(),
    'total': total,
  };
}

enum OrderStatus { pending, inProgress, delivered, completed, picked , ordered}
