

import 'package:shom_gn/models/model.dart';
import 'package:shom_gn/models/service_model.dart';

abstract class OrderItemModel<S extends ServiceModel> extends Model {
  final S service;
   int qty;
   double total;

  OrderItemModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.service,
    required this.qty,
    required this.total
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'service': service.toJson(),
    'qty': qty,
    'total': total
  };
}
