 

import 'package:shom_gn/models/model.dart';

abstract class ProductModel extends Model {
  final double? price;
  final String? supplierId;
  final bool isAvailable;
  final String? imageUrl;
  final String? category;
  final String currency;
  final List<String?>? materials;

  ProductModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.price,
    required this.supplierId,
    required this.imageUrl,
    required this.category,
    required this.isAvailable,
    required this.currency,
    this.materials,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'supplierId': supplierId,
    'price': price,
    'isAvailable': isAvailable,
    'imageUrl': imageUrl ?? '',
    'category': category ?? '',
    'currency': currency,
    'materials' : materials?.map( (e) => e != null ? e.toJson(): '').toList()
  };
}

extension on String {
  toJson() {}
}

 
