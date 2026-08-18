import 'package:shom_gn/models/product_model.dart';

import 'price.dart';

enum BookingStatus { pending, confirmed, cancelled, completed }

enum BookingType { flight, hotel, flightAndHotel }

abstract class BookingModel extends ProductModel {
  final Price totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;
  final DateTime? paymentDate;
  final String? paymentMethod;
  final String? confirmationNumber;
  BookingModel({
    required this.totalPrice,
    required this.status,
    required this.bookingDate,
    required this.paymentDate,
    required this.paymentMethod,
    required this.confirmationNumber,
    required super.id,
    required super.name,
    required super.createdAt,
    required super.price,
    required super.supplierId,
    required super.imageUrl,
    required super.category,
    required super.isAvailable,
    required super.currency,
  });

  bool get isPaid => paymentDate != null;
  bool get isCompleted => status == BookingStatus.completed;

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'totalPrice': totalPrice.toJson(),
    'status': status.name,
    'bookingDate': bookingDate.toIso8601String(),
    'paymentDate': paymentDate?.toIso8601String(),
    'paymentMethod': paymentMethod,
    'confirmationNumber': confirmationNumber,
  };
}
