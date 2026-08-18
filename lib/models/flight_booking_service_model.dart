import 'package:shom_gn/models/flight_booking_model.dart';
import 'package:shom_gn/models/service_model.dart';

class FlightBookingServiceModel extends ServiceModel<FlightBookingModel> {
  final String? cabinClass;
  final double? ticketPrice;
  final double? taxes;
  final double? serviceFee;

  FlightBookingServiceModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.minPrice,
    required super.maxPrice,
    required super.basePrice,
    required super.active,
    required super.estimatedDuration,
    required super.product,
    this.cabinClass,
    this.ticketPrice,
    this.taxes,
    this.serviceFee,
  });

  @override
  String getCollectionName() {
    return "flight_booking";
  }
}
