class FlightSearchCriteria {
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureDate;
  final DateTime? returnDate;
  final int adults;
  final int children;
  final int infants;
  final String? cabin;
  final String? currency;
  final int? maxPrice;
  final int? minPrice;
  final List<String>? airlines;
  final bool directOnly;
  final int? maxStops;

  FlightSearchCriteria({
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureDate,
    this.returnDate,
    required this.adults,
    this.children = 0,
    this.infants = 0,
    this.cabin,
    this.currency,
    this.maxPrice,
    this.minPrice,
    this.airlines,
    this.directOnly = false,
    this.maxStops,
  });

  bool get isRoundTrip => returnDate != null;
  int get totalPassengers => adults + children + infants;

  Map<String, dynamic> toJson() {
    return {
      'departureAirport': departureAirport,
      'arrivalAirport': arrivalAirport,
      'departureDate': departureDate.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
      'adults': adults,
      'children': children,
      'infants': infants,
      'cabin': cabin,
      'currency': currency,
      'maxPrice': maxPrice,
      'minPrice': minPrice,
      'airlines': airlines,
      'directOnly': directOnly,
      'maxStops': maxStops,
    };
  }

  Map<String, dynamic> toApiQuery() {
    return {
      'originLocationCode': departureAirport,
      'destinationLocationCode': arrivalAirport,
      'departureDate': departureDate.toIso8601String().split('T')[0],
      'returnDate': returnDate?.toIso8601String().split('T')[0],
      'adults': adults.toString(),
      'children': children > 0 ? children.toString() : null,
      'infants': infants > 0 ? infants.toString() : null,
      'travelClass': cabin,
      'currencyCode': currency,
      'maxPrice': maxPrice,
      'nonStop': directOnly,
    }..removeWhere((key, value) => value == null);
  }
}

class HotelSearchCriteria {
  final String city;
  final String? countryCode;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int rooms;
  final int adults;
  final int children;
  final String? currency;
  final int? maxPrice;
  final int? minPrice;
  final double? minRating;
  final List<String>? amenities;
  final bool? freeWifi;
  final bool? freeParking;
  final bool? swimmingPool;

  HotelSearchCriteria({
    required this.city,
    this.countryCode,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.adults,
    this.children = 0,
    this.currency,
    this.maxPrice,
    this.minPrice,
    this.minRating,
    this.amenities,
    this.freeWifi,
    this.freeParking,
    this.swimmingPool,
  });

  int get numberOfNights => checkOutDate.difference(checkInDate).inDays;
  int get totalGuests => adults + children;

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'countryCode': countryCode,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'rooms': rooms,
      'adults': adults,
      'children': children,
      'currency': currency,
      'maxPrice': maxPrice,
      'minPrice': minPrice,
      'minRating': minRating,
      'amenities': amenities,
      'freeWifi': freeWifi,
      'freeParking': freeParking,
      'swimmingPool': swimmingPool,
    };
  }

  Map<String, dynamic> toApiQuery() {
    return {
      'cityCode': city,
      'checkInDate': checkInDate.toIso8601String().split('T')[0],
      'checkOutDate': checkOutDate.toIso8601String().split('T')[0],
      'roomQuantity': rooms.toString(),
      'adults': adults.toString(),
      'children': children > 0 ? children.toString() : null,
      'currencyCode': currency,
    }..removeWhere((key, value) => value == null);
  }
}

class ReviewSearchCriteria {
  final String? hotelId;
  final int? minRating;
  final int? maxRating;
  final int page;
  final int pageSize;

  ReviewSearchCriteria({
    this.hotelId,
    this.minRating,
    this.maxRating,
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'hotelId': hotelId,
      'minRating': minRating,
      'maxRating': maxRating,
      'page': page,
      'pageSize': pageSize,
    };
  }
}
