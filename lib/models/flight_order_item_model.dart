import 'package:shom_gn/models/flight_booking_service_model.dart';
import 'package:shom_gn/models/order_item_model.dart';

class FlightOrderItemModel extends OrderItemModel<FlightBookingServiceModel> {
  FlightOrderItemModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.service,
    required super.qty,
    required super.total,
  });
}
