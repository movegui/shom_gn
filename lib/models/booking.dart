import 'flight.dart';
import 'hotel.dart';
import 'passenger.dart';
import 'price.dart';

enum BookingStatus { pending, confirmed, cancelled, completed }

enum BookingType { flight, hotel, flightAndHotel }

class FlightBooking {
  final String id;
  final String bookingReference;
  final Flight flight;
  final List<Passenger> passengers;
  final Price totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;
  final DateTime? paymentDate;
  final String? paymentMethod;
  final String? confirmationNumber;
  final bool seatSelectionDone;
  final bool bagagePaid;
  final DateTime? departureDate;
  final List<String> selectedSeats;

  FlightBooking({
    required this.id,
    required this.bookingReference,
    required this.flight,
    required this.passengers,
    required this.totalPrice,
    this.status = BookingStatus.pending,
    required this.bookingDate,
    this.paymentDate,
    this.paymentMethod,
    this.confirmationNumber,
    this.seatSelectionDone = false,
    this.bagagePaid = false,
    this.departureDate,
    this.selectedSeats = const [],
  });

  bool get isPaid => paymentDate != null;
  bool get isCompleted => status == BookingStatus.completed;

  factory FlightBooking.fromJson(Map<String, dynamic> json) {
    return FlightBooking(
      id: json['id'] ?? '',
      bookingReference: json['bookingReference'] ?? '',
      flight: Flight.fromJson(json['flight'] ?? {}),
      passengers: (json['passengers'] as List?)
          ?.map((p) => Passenger.fromJson(p))
          .toList() ?? [],
      totalPrice: Price.fromJson(json['totalPrice'] ?? {}),
      status: BookingStatus.values.byName(json['status'] ?? 'pending'),
      bookingDate: DateTime.parse(json['bookingDate'] ?? DateTime.now().toIso8601String()),
      paymentDate: json['paymentDate'] != null ? DateTime.parse(json['paymentDate']) : null,
      paymentMethod: json['paymentMethod'],
      confirmationNumber: json['confirmationNumber'],
      seatSelectionDone: json['seatSelectionDone'] ?? false,
      bagagePaid: json['bagagePaid'] ?? false,
      selectedSeats: List<String>.from(json['selectedSeats'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingReference': bookingReference,
      'flight': flight.toJson(),
      'passengers': passengers.map((p) => p.toJson()).toList(),
      'totalPrice': totalPrice.toJson(),
      'status': status.name,
      'bookingDate': bookingDate.toIso8601String(),
      'paymentDate': paymentDate?.toIso8601String(),
      'paymentMethod': paymentMethod,
      'confirmationNumber': confirmationNumber,
      'seatSelectionDone': seatSelectionDone,
      'bagagePaid': bagagePaid,
      'selectedSeats': selectedSeats,
    };
  }

  @override
  String toString() => 'Flight Booking: $bookingReference';
}

class HotelBooking {
  final String id;
  final String bookingReference;
  final Hotel hotel;
  final Room room;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfNights;
  final List<Passenger> guests;
  final Price totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;
  final DateTime? paymentDate;
  final String? paymentMethod;
  final String? confirmationNumber;
  final String? specialRequests;
  final bool breakfastIncluded;
  final bool cancellationFree;

  HotelBooking({
    required this.id,
    required this.bookingReference,
    required this.hotel,
    required this.room,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfNights,
    required this.guests,
    required this.totalPrice,
    this.status = BookingStatus.pending,
    required this.bookingDate,
    this.paymentDate,
    this.paymentMethod,
    this.confirmationNumber,
    this.specialRequests,
    this.breakfastIncluded = false,
    this.cancellationFree = true,
  });

  bool get isPaid => paymentDate != null;

  factory HotelBooking.fromJson(Map<String, dynamic> json) {
    return HotelBooking(
      id: json['id'] ?? '',
      bookingReference: json['bookingReference'] ?? '',
      hotel: Hotel.fromJson(json['hotel'] ?? {}),
      room: Room.fromJson(json['room'] ?? {}),
      checkInDate: DateTime.parse(json['checkInDate'] ?? DateTime.now().toIso8601String()),
      checkOutDate: DateTime.parse(json['checkOutDate'] ?? DateTime.now().toIso8601String()),
      numberOfNights: json['numberOfNights'] ?? 0,
      guests: (json['guests'] as List?)
          ?.map((g) => Passenger.fromJson(g))
          .toList() ?? [],
      totalPrice: Price.fromJson(json['totalPrice'] ?? {}),
      status: BookingStatus.values.byName(json['status'] ?? 'pending'),
      bookingDate: DateTime.parse(json['bookingDate'] ?? DateTime.now().toIso8601String()),
      paymentDate: json['paymentDate'] != null ? DateTime.parse(json['paymentDate']) : null,
      paymentMethod: json['paymentMethod'],
      confirmationNumber: json['confirmationNumber'],
      specialRequests: json['specialRequests'],
      breakfastIncluded: json['breakfastIncluded'] ?? false,
      cancellationFree: json['cancellationFree'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
  }

  @override
  String toString() => 'Hotel Booking: $bookingReference';
}

class CombinedBooking {
  final String id;
  final FlightBooking? flightBooking;
  final HotelBooking? hotelBooking;
  final Price totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;

  CombinedBooking({
    required this.id,
    this.flightBooking,
    this.hotelBooking,
    required this.totalPrice,
    this.status = BookingStatus.pending,
    required this.bookingDate,
  });

  factory CombinedBooking.fromJson(Map<String, dynamic> json) {
    return CombinedBooking(
      id: json['id'] ?? '',
      flightBooking: json['flightBooking'] != null ? FlightBooking.fromJson(json['flightBooking']) : null,
      hotelBooking: json['hotelBooking'] != null ? HotelBooking.fromJson(json['hotelBooking']) : null,
      totalPrice: Price.fromJson(json['totalPrice'] ?? {}),
      status: BookingStatus.values.byName(json['status'] ?? 'pending'),
      bookingDate: DateTime.parse(json['bookingDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flightBooking': flightBooking?.toJson(),
      'hotelBooking': hotelBooking?.toJson(),
      'totalPrice': totalPrice.toJson(),
      'status': status.name,
      'bookingDate': bookingDate.toIso8601String(),
    };
  }
}
