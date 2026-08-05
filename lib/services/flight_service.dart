import '../models/models.dart';
import 'amadeus_api_service.dart';

class FlightService {
  final AmadeusApiService apiService;

  const FlightService({required this.apiService});

  /// Search for flights based on criteria
  Future<ApiResult<List<Flight>>> searchFlights(FlightSearchCriteria criteria) async {
    return await apiService.searchFlights(criteria);
  }

  /// Get flight details by ID
  Future<ApiResult<Flight>> getFlightDetails(String flightId) async {
    return await apiService.getFlightDetails(flightId);
  }

  /// Compare multiple flights
  List<Flight> compareFlights(List<Flight> flights) {
    flights.sort((a, b) => a.price.total.compareTo(b.price.total));
    return flights;
  }

  /// Filter flights by price
  List<Flight> filterByPrice(List<Flight> flights, double minPrice, double maxPrice) {
    return flights
        .where((f) => f.price.total >= minPrice && f.price.total <= maxPrice)
        .toList();
  }

  /// Filter flights by duration
  List<Flight> filterByDuration(List<Flight> flights, int maxMinutes) {
    return flights.where((f) => f.totalDuration <= maxMinutes).toList();
  }

  /// Filter flights by stops
  List<Flight> filterByStops(List<Flight> flights, int maxStops) {
    return flights.where((f) => f.numberOfStops <= maxStops).toList();
  }

  /// Filter direct flights only
  List<Flight> filterDirectFlights(List<Flight> flights) {
    return flights.where((f) => f.numberOfStops == 0).toList();
  }

  /// Filter flights by specific airline
  List<Flight> filterByAirline(List<Flight> flights, String airlineCode) {
    return flights
        .where((f) => f.segments.any((s) => s.airline.code == airlineCode))
        .toList();
  }

  /// Get cheapest flight
  Flight? getCheapestFlight(List<Flight> flights) {
    if (flights.isEmpty) return null;
    return flights.reduce((a, b) => a.price.total < b.price.total ? a : b);
  }

  /// Get fastest flight
  Flight? getFastestFlight(List<Flight> flights) {
    if (flights.isEmpty) return null;
    return flights.reduce((a, b) => a.totalDuration < b.totalDuration ? a : b);
  }

  /// Book a flight
  Future<ApiResult<FlightBooking>> bookFlight(
    Flight flight,
    List<Passenger> passengers, {
    required String paymentMethod,
  }) async {
    final booking = FlightBooking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      bookingReference: _generateBookingReference(),
      flight: flight,
      passengers: passengers,
      totalPrice: flight.price,
      bookingDate: DateTime.now(),
      paymentMethod: paymentMethod,
    );

    return await apiService.createFlightBooking(booking);
  }

  /// Cancel flight booking
  Future<ApiResult<void>> cancelBooking(String bookingId) async {
    return await apiService.cancelFlightBooking(bookingId);
  }

  /// Generate booking reference (6 characters alphanumeric)
  String _generateBookingReference() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = '';
    for (int i = 0; i < 6; i++) {
      result += chars[(DateTime.now().millisecondsSinceEpoch + i) % chars.length];
    }
    return result;
  }
}
