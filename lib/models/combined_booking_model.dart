import 'package:shom_gn/models/booking_model.dart';
import 'package:shom_gn/models/flight_booking_model.dart';
import 'package:shom_gn/models/hotel_booking_model.dart';
import 'package:shom_gn/models/model.dart';
import 'package:shom_gn/models/price.dart';

class CombinedBookingModel extends Model {
  final FlightBookingModel? flightBooking;
  final HotelBookingModel? hotelBooking;
  final Price totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;

  CombinedBookingModel({
    this.flightBooking,
    this.hotelBooking,
    required this.totalPrice,
    this.status = BookingStatus.pending,
    required this.bookingDate,
    required super.id,
    required super.name,
    required super.createdAt,
  });

  factory CombinedBookingModel.fromJson(Map<String, dynamic> json) {
    return CombinedBookingModel(
      id: json['id'] ?? '',
      name: json['name'],
      createdAt: json['createdAt'].toDate(),
      flightBooking: json['flightBooking'] != null
          ? FlightBookingModel.fromJson(json['flightBooking'])
          : null,
      hotelBooking: json['hotelBooking'] != null
          ? HotelBookingModel.fromJson(json['hotelBooking'])
          : null,
      totalPrice: Price.fromJson(json['totalPrice'] ?? {}),
      status: BookingStatus.values.byName(json['status'] ?? 'pending'),
      bookingDate: DateTime.parse(
        json['bookingDate'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'flightBooking': flightBooking?.toJson(),
    'hotelBooking': hotelBooking?.toJson(),
    'totalPrice': totalPrice.toJson(),
    'status': status.name,
    'bookingDate': bookingDate.toIso8601String(),
  };
}
