import 'package:shom_gn/models/address_model.dart';
import 'package:shom_gn/models/booking_model.dart';
import 'package:shom_gn/models/flight.dart';
import 'package:shom_gn/models/passenger_model.dart';
import 'package:shom_gn/models/price.dart';

class FlightBookingModel extends BookingModel {
  final String bookingReference;
  final Flight flight;
  final List<PassengerModel> passengers;
  final bool seatSelectionDone;
  final bool bagagePaid;
  final DateTime? departureDate;
  final List<String> selectedSeats;
  final AddressModel? departure;
  final AddressModel? arrival;


  FlightBookingModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.bookingReference,
    required this.flight,
    required this.passengers,
    this.seatSelectionDone = false,
    this.bagagePaid = false,
    required this.departureDate,
    this.selectedSeats = const [],
    required super.totalPrice,
    super.status = BookingStatus.pending,
    required super.bookingDate,
    required super.paymentDate,
    required super.paymentMethod,
    required super.confirmationNumber,
    required super.price,
    required super.supplierId,
    required super.imageUrl,
    required super.category,
    required super.isAvailable,
    required super.currency,
    required this.departure,
    required this.arrival,

  });

  factory FlightBookingModel.fromJson(Map<String, dynamic> json) {
    return FlightBookingModel(
      id: json['id'] ?? '',
      name: json['name'],
      createdAt: json['createdAt'].toDate(),
      bookingReference: json['bookingReference'] ?? '',
      flight: Flight.fromJson(json['flight'] ?? {}),
      passengers:
          (json['passengers'] as List?)
              ?.map((p) => PassengerModel.fromJson(p))
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
      seatSelectionDone: json['seatSelectionDone'] ?? false,
      bagagePaid: json['bagagePaid'] ?? false,
      selectedSeats: List<String>.from(json['selectedSeats'] ?? []),
      price: json['price'] ?? 0,
      supplierId: json['supplierId'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      isAvailable: json['isAvailable'],
      currency: json['currency'],
      departureDate: json['departureDate']?.toDate(),
      departure: json['departure'],
      arrival: json['arrival'],
    
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'bookingReference': bookingReference,
    'flight': flight.toJson(),
    'passengers': passengers.map((p) => p.toJson()).toList(),
    'seatSelectionDone': seatSelectionDone,
    'bagagePaid': bagagePaid,
    'selectedSeats': selectedSeats,
    'departureDate': departureDate,
    'departure': departure,
    'arrival': arrival,
  
  };

  @override
  String toString() => 'Flight Booking: $bookingReference';
}
