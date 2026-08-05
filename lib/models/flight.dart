import 'airline.dart';
import 'airport.dart';
import 'price.dart';

enum FlightStatus { active, pending, cancelled, completed }

class Segment {
  final String flightNumber;
  final Airline airline;
  final Airport departure;
  final Airport arrival;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int duration; // in minutes
  final String? aircraft;
  final int? stops;
  final String? cabin;
  final String? class_;

  Segment({
    required this.flightNumber,
    required this.airline,
    required this.departure,
    required this.arrival,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    this.aircraft,
    this.stops,
    this.cabin,
    this.class_,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      flightNumber: json['operating']?['carrierCode'] != null 
        ? '${json['operating']['carrierCode']}${json['number']}'
        : json['number'] ?? '',
      airline: Airline(
        code: json['operating']?['carrierCode'] ?? json['carrierCode'] ?? '',
        name: '',
      ),
      departure: Airport(
        iataCode: json['departure']?['iataCode'] ?? '',
        name: '',
        city: '',
        country: '',
      ),
      arrival: Airport(
        iataCode: json['arrival']?['iataCode'] ?? '',
        name: '',
        city: '',
        country: '',
      ),
      departureTime: DateTime.parse(json['departure']?['at'] ?? DateTime.now().toIso8601String()),
      arrivalTime: DateTime.parse(json['arrival']?['at'] ?? DateTime.now().toIso8601String()),
      duration: _parseDuration(json['duration'] ?? 'PT0H'),
      aircraft: json['aircraft']?['code'],
      stops: json['stops']?.length,
      cabin: json['cabin'],
      class_: json['class'],
    );
  }

  static int _parseDuration(String duration) {
    // Parse ISO 8601 duration format: PT1H30M
    int minutes = 0;
    if (duration.contains('H')) {
      final hourPart = duration.split('H')[0].split('T').last;
      minutes += int.tryParse(hourPart) ?? 0 * 60;
    }
    if (duration.contains('M')) {
      final minutePart = duration.split('M')[0].split('H').last;
      minutes += int.tryParse(minutePart) ?? 0;
    }
    return minutes;
  }

  String get durationFormatted {
    final hours = duration ~/ 60;
    final mins = duration % 60;
    return '${hours}h ${mins}m';
  }

  Map<String, dynamic> toJson() {
    return {
      'flightNumber': flightNumber,
      'airline': airline.toJson(),
      'departure': departure.toJson(),
      'arrival': arrival.toJson(),
      'departureTime': departureTime.toIso8601String(),
      'arrivalTime': arrivalTime.toIso8601String(),
      'duration': duration,
      'aircraft': aircraft,
      'stops': stops,
      'cabin': cabin,
      'class': class_,
    };
  }
}

class Flight {
  final String id;
  final List<Segment> segments;
  final Price price;
  final int numberOfBookableSeats;
  final String itineraryId;
  final FlightStatus status;
  final bool refundable;
  final DateTime? validatingAirlineCode;

  Flight({
    required this.id,
    required this.segments,
    required this.price,
    required this.numberOfBookableSeats,
    required this.itineraryId,
    this.status = FlightStatus.active,
    this.refundable = false,
    this.validatingAirlineCode,
  });

  DateTime get departureTime => segments.first.departureTime;
  DateTime get arrivalTime => segments.last.arrivalTime;
  int get totalDuration => segments.fold<int>(0, (sum, seg) => sum + seg.duration);
  int get numberOfStops => segments.length - 1;

  String get durationFormatted {
    final hours = totalDuration ~/ 60;
    final mins = totalDuration % 60;
    return '${hours}h ${mins}m';
  }

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'] ?? '',
      segments: (json['itineraries']?[0]?['segments'] as List?)
          ?.map((seg) => Segment.fromJson(seg))
          .toList() ?? [],
      price: Price.fromJson(json['price'] ?? {}),
      numberOfBookableSeats: json['numberOfBookableSeats'] ?? 0,
      itineraryId: json['itineraryId'] ?? '',
      status: FlightStatus.active,
      refundable: json['pricingOptions']?['fareDetailsBySegment']?[0]?['amenities'] != null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'segments': segments.map((s) => s.toJson()).toList(),
      'price': price.toJson(),
      'numberOfBookableSeats': numberOfBookableSeats,
      'itineraryId': itineraryId,
      'status': status.name,
      'refundable': refundable,
    };
  }

  @override
  String toString() => '${segments.first.departure.iataCode} -> ${segments.last.arrival.iataCode}';
}
