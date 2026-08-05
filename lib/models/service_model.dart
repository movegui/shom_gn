

import 'package:shom_gn/models/model.dart';
import 'package:shom_gn/models/product_model.dart';

abstract class ServiceModel<M extends ProductModel> extends Model {
  final double? minPrice;
  final double? maxPrice;
  final double? basePrice;
  final bool? active;
  final Duration? estimatedDuration;
  final M product;

  ServiceModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.minPrice,
    required this.maxPrice,
    required this.basePrice,
    required this.active,
    required this.estimatedDuration,
    required this.product
  });

  String getCollectionName();

    @override
  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'minPrice': minPrice,
    'maxPrice': maxPrice,
    'basePrice': basePrice,
    'active': active,
    'estimatedDuration':
        estimatedDuration != null ? estimatedDuration!.inMicroseconds : 0,
  };

}
