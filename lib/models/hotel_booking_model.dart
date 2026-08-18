import 'package:shom_gn/models/booking_model.dart';
import 'package:shom_gn/models/hotel.dart';
import 'package:shom_gn/models/passenger_model.dart';
import 'package:shom_gn/models/price.dart';

class HotelBookingModel extends BookingModel {
  final String bookingReference;
  final Hotel hotel;
  final Room room;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfNights;
  final List<PassengerModel> guests;
  final String? specialRequests;
  final bool breakfastIncluded;
  final bool cancellationFree;

  HotelBookingModel({
    required this.bookingReference,
    required this.hotel,
    required this.room,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfNights,
    required this.guests,
    this.specialRequests,
    this.breakfastIncluded = false,
    this.cancellationFree = true,
    required super.totalPrice,
    required super.status,
    required super.bookingDate,
    required super.paymentDate,
    required super.paymentMethod,
    required super.confirmationNumber,
    required super.name,
    required super.createdAt,
    required super.id,
    required super.price,
    required super.supplierId,
    required super.imageUrl,
    required super.category,
    required super.isAvailable,
    required super.currency,
  });

  factory HotelBookingModel.fromJson(Map<String, dynamic> json) {
    return HotelBookingModel(
      id: json['id'] ?? '',
      name: json['name'],
      createdAt: json['createdAt'].toDate(),
      bookingReference: json['bookingReference'] ?? '',
      hotel: Hotel.fromJson(json['hotel'] ?? {}),
      room: Room.fromJson(json['room'] ?? {}),
      checkInDate: DateTime.parse(
        json['checkInDate'] ?? DateTime.now().toIso8601String(),
      ),
      checkOutDate: DateTime.parse(
        json['checkOutDate'] ?? DateTime.now().toIso8601String(),
      ),
      numberOfNights: json['numberOfNights'] ?? 0,
      guests:
          (json['guests'] as List?)
              ?.map((g) => PassengerModel.fromJson(g))
              .toList() ??
          [],
      totalPrice: Price.fromJson(json['totalPrice'] ?? {}),
      status: BookingStatus.values.byName(json['status'] ?? 'pending'),
      bookingDate: DateTime.parse(
        json['bookingDate'] ?? DateTime.now().toIso8601String(),
      ),
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'])
          : null,
      paymentMethod: json['paymentMethod'],
      confirmationNumber: json['confirmationNumber'],
      specialRequests: json['specialRequests'],
      breakfastIncluded: json['breakfastIncluded'] ?? false,
      cancellationFree: json['cancellationFree'] ?? true,
            price: json['price'] ?? 0,
      supplierId: json['supplierId'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      isAvailable: json['isAvailable'],
      currency: json['currency'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'bookingReference': bookingReference,
    'hotel': hotel.toJson(),
    'room': room.toJson(),
    'checkInDate': checkInDate.toIso8601String(),
    'checkOutDate': checkOutDate.toIso8601String(),
    'numberOfNights': numberOfNights,
    'guests': guests.map((g) => g.toJson()).toList(),
    'totalPrice': totalPrice.toJson(),
    'status': status.name,
    'bookingDate': bookingDate.toIso8601String(),
    'paymentDate': paymentDate?.toIso8601String(),
    'paymentMethod': paymentMethod,
    'confirmationNumber': confirmationNumber,
    'specialRequests': specialRequests,
    'breakfastIncluded': breakfastIncluded,
    'cancellationFree': cancellationFree,
  };

  @override
  String toString() => 'Hotel Booking: $bookingReference';
}
