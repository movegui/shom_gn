import 'package:shom_gn/models/model.dart';

class DestinationModel extends Model {
  final String city;
  final double price;
  final String? imageUrl;

  DestinationModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.city,
    required this.price,
    required this.imageUrl,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        id: json['id'],
        name: json['name'] ?? '',
        createdAt: json['createdAt'].toDate(),
        city: json['city'],
        price: json['price'],
        imageUrl: json['imageUrl'],
      );
}
