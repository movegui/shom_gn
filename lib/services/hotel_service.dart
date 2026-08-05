import '../models/models.dart';
import 'amadeus_api_service.dart';

class HotelService {
  final AmadeusApiService apiService;

  const HotelService({required this.apiService});

  /// Search for hotels based on criteria
  Future<ApiResult<List<Hotel>>> searchHotels(HotelSearchCriteria criteria) async {
    try {
      // This would integrate with Amadeus Hotel Search API
      // For now, returning success with empty list as placeholder
      return ApiResult.success([]);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Hotel search failed: $e'));
    }
  }

  /// Get hotel details by ID
  Future<ApiResult<Hotel>> getHotelDetails(String hotelId) async {
    try {
      // Integration with Amadeus Hotel Details API
      return ApiResult.error(NotFoundException(message: 'Hotel not found'));
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Get hotel details failed: $e'));
    }
  }

  /// Get hotel reviews
  Future<ApiResult<PaginatedResponse<Map<String, dynamic>>>> getHotelReviews(
    String hotelId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      // Integration with hotel reviews API
      return ApiResult.error(NotFoundException(message: 'Reviews not found'));
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Get reviews failed: $e'));
    }
  }

  /// Filter hotels by price
  List<Hotel> filterByPrice(List<Hotel> hotels, double minPrice, double maxPrice) {
    return hotels
        .where((h) => h.pricePerNight.total >= minPrice && h.pricePerNight.total <= maxPrice)
        .toList();
  }

  /// Filter hotels by rating
  List<Hotel> filterByRating(List<Hotel> hotels, double minRating) {
    return hotels.where((h) => h.rating >= minRating).toList();
  }

  /// Filter hotels by amenities
  List<Hotel> filterByAmenities(List<Hotel> hotels, List<String> requiredAmenities) {
    return hotels
        .where((h) => requiredAmenities.every((amenity) => h.amenities.contains(amenity)))
        .toList();
  }

  /// Sort hotels by price
  List<Hotel> sortByPrice(List<Hotel> hotels, {bool ascending = true}) {
    hotels.sort((a, b) => ascending
        ? a.pricePerNight.total.compareTo(b.pricePerNight.total)
        : b.pricePerNight.total.compareTo(a.pricePerNight.total));
    return hotels;
  }

  /// Sort hotels by rating
  List<Hotel> sortByRating(List<Hotel> hotels, {bool ascending = false}) {
    hotels.sort((a, b) => ascending
        ? a.rating.compareTo(b.rating)
        : b.rating.compareTo(a.rating));
    return hotels;
  }

  /// Get cheapest hotel
  Hotel? getCheapestHotel(List<Hotel> hotels) {
    if (hotels.isEmpty) return null;
    return hotels.reduce((a, b) => a.pricePerNight.total < b.pricePerNight.total ? a : b);
  }

  /// Get highest rated hotel
  Hotel? getHighestRatedHotel(List<Hotel> hotels) {
    if (hotels.isEmpty) return null;
    return hotels.reduce((a, b) => a.rating > b.rating ? a : b);
  }

  /// Book a hotel
  Future<ApiResult<HotelBooking>> bookHotel(
    Hotel hotel,
    Room room,
    DateTime checkInDate,
    DateTime checkOutDate,
    List<Passenger> guests, {
    required String paymentMethod,
    String? specialRequests,
  }) async {
    final numberOfNights = checkOutDate.difference(checkInDate).inDays;
    final totalPrice = Price(
      total: room.price.total * numberOfNights,
      base: room.price.base * numberOfNights,
      currency: room.price.currency,
    );

    final booking = HotelBooking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      bookingReference: _generateBookingReference(),
      hotel: hotel,
      room: room,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      numberOfNights: numberOfNights,
      guests: guests,
      totalPrice: totalPrice,
      bookingDate: DateTime.now(),
      paymentMethod: paymentMethod,
      specialRequests: specialRequests,
    );

    try {
      // Integration with booking API
      return ApiResult.success(booking);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Hotel booking failed: $e'));
    }
  }

  /// Cancel hotel booking
  Future<ApiResult<void>> cancelBooking(String bookingId) async {
    try {
      // Integration with cancellation API
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Cancel booking failed: $e'));
    }
  }

  /// Modify hotel booking
  Future<ApiResult<HotelBooking>> modifyBooking(
    HotelBooking booking,
    DateTime? newCheckIn,
    DateTime? newCheckOut,
  ) async {
    try {
      // Integration with modification API
      return ApiResult.success(booking);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Modify booking failed: $e'));
    }
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

  /// Calculate total cost for hotel stay
  double calculateTotalCost(
    double pricePerNight,
    int numberOfNights,
    double taxPercentage ,
  ) {
    final subtotal = pricePerNight * numberOfNights;
    final tax = subtotal * (taxPercentage / 100);
    return subtotal + tax;
  }
}
