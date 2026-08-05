import '../models/models.dart';
import '../services/services.dart';

class FlightRepository {
  final FlightService flightService;

  FlightRepository({required this.flightService});

  /// Search for flights
  Future<ApiResult<List<Flight>>> searchFlights(FlightSearchCriteria criteria) async {
    return await flightService.searchFlights(criteria);
  }

  /// Get flight details
  Future<ApiResult<Flight>> getFlightDetails(String flightId) async {
    return await flightService.getFlightDetails(flightId);
  }

  /// Search and filter flights by price
  Future<ApiResult<List<Flight>>> searchFlightsByPrice(
    FlightSearchCriteria criteria,
    double minPrice,
    double maxPrice,
  ) async {
    final result = await searchFlights(criteria);
    return result.when(
      onSuccess: (flights) => ApiResult.success(
        flightService.filterByPrice(flights, minPrice, maxPrice),
      ),
      onError: (error) => ApiResult.error(error),
    );
  }

  /// Search and get cheapest flight
  Future<ApiResult<Flight?>> searchAndGetCheapestFlight(FlightSearchCriteria criteria) async {
    final result = await searchFlights(criteria);
    return result.when(
      onSuccess: (flights) => ApiResult.success(
        flightService.getCheapestFlight(flights),
      ),
      onError: (error) => ApiResult.error(error),
    );
  }

  /// Search and get fastest flight
  Future<ApiResult<Flight?>> searchAndGetFastestFlight(FlightSearchCriteria criteria) async {
    final result = await searchFlights(criteria);
    return result.when(
      onSuccess: (flights) => ApiResult.success(
        flightService.getFastestFlight(flights),
      ),
      onError: (error) => ApiResult.error(error),
    );
  }

  /// Book flight
  Future<ApiResult<FlightBooking>> bookFlight(
    Flight flight,
    List<Passenger> passengers, {
    required String paymentMethod,
  }) async {
    return await flightService.bookFlight(
      flight,
      passengers,
      paymentMethod: paymentMethod,
    );
  }

  /// Cancel flight booking
  Future<ApiResult<void>> cancelBooking(String bookingId) async {
    return await flightService.cancelBooking(bookingId);
  }
}

class HotelRepository {
  final HotelService hotelService;

  HotelRepository({required this.hotelService});

  /// Search for hotels
  Future<ApiResult<List<Hotel>>> searchHotels(HotelSearchCriteria criteria) async {
    return await hotelService.searchHotels(criteria);
  }

  /// Get hotel details
  Future<ApiResult<Hotel>> getHotelDetails(String hotelId) async {
    return await hotelService.getHotelDetails(hotelId);
  }

  /// Get hotel reviews
  Future<ApiResult<PaginatedResponse<Map<String, dynamic>>>> getHotelReviews(
    String hotelId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    return await hotelService.getHotelReviews(hotelId, page: page, pageSize: pageSize);
  }

  /// Search and filter hotels by price
  Future<ApiResult<List<Hotel>>> searchHotelsByPrice(
    HotelSearchCriteria criteria,
    double minPrice,
    double maxPrice,
  ) async {
    final result = await searchHotels(criteria);
    return result.when(
      onSuccess: (hotels) => ApiResult.success(
        hotelService.filterByPrice(hotels, minPrice, maxPrice),
      ),
      onError: (error) => ApiResult.error(error),
    );
  }

  /// Search and get highest rated hotel
  Future<ApiResult<Hotel?>> searchAndGetHighestRatedHotel(HotelSearchCriteria criteria) async {
    final result = await searchHotels(criteria);
    return result.when(
      onSuccess: (hotels) => ApiResult.success(
        hotelService.getHighestRatedHotel(hotels),
      ),
      onError: (error) => ApiResult.error(error),
    );
  }

  /// Book hotel
  Future<ApiResult<HotelBooking>> bookHotel(
    Hotel hotel,
    Room room,
    DateTime checkInDate,
    DateTime checkOutDate,
    List<Passenger> guests, {
    required String paymentMethod,
    String? specialRequests,
  }) async {
    return await hotelService.bookHotel(
      hotel,
      room,
      checkInDate,
      checkOutDate,
      guests,
      paymentMethod: paymentMethod,
      specialRequests: specialRequests,
    );
  }

  /// Cancel hotel booking
  Future<ApiResult<void>> cancelBooking(String bookingId) async {
    return await hotelService.cancelBooking(bookingId);
  }

  /// Modify hotel booking
  Future<ApiResult<HotelBooking>> modifyBooking(
    HotelBooking booking,
    DateTime? newCheckIn,
    DateTime? newCheckOut,
  ) async {
    return await hotelService.modifyBooking(booking, newCheckIn, newCheckOut);
  }
}

class BookingRepository {
  final BookingService bookingService;

  BookingRepository({required this.bookingService});

  /// Get all user bookings
  Future<ApiResult<List<CombinedBooking>>> getUserBookings() async {
    return await bookingService.getUserBookings();
  }

  /// Get booking details
  Future<ApiResult<CombinedBooking>> getBookingDetails(String bookingId) async {
    return await bookingService.getBookingDetails(bookingId);
  }

  /// Get booking by reference
  Future<ApiResult<CombinedBooking>> getBookingByReference(String reference) async {
    return await bookingService.getBookingByReference(reference);
  }

  /// Create combined booking
  Future<ApiResult<CombinedBooking>> createCombinedBooking({
    required FlightBooking flightBooking,
    required HotelBooking hotelBooking,
  }) async {
    return await bookingService.createCombinedBooking(
      flightBooking: flightBooking,
      hotelBooking: hotelBooking,
    );
  }

  /// Cancel booking
  Future<ApiResult<void>> cancelBooking(String bookingId) async {
    return await bookingService.cancelBooking(bookingId);
  }

  /// Update booking
  Future<ApiResult<CombinedBooking>> updateBooking(
    String bookingId,
    CombinedBooking booking,
  ) async {
    return await bookingService.updateBooking(bookingId, booking);
  }

  /// Send confirmation email
  Future<ApiResult<void>> sendConfirmationEmail(String bookingId) async {
    return await bookingService.sendConfirmationEmail(bookingId);
  }

  /// Get booking statistics
  Future<ApiResult<Map<String, dynamic>>> getBookingStats() async {
    return await bookingService.getBookingStats();
  }
}

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  /// Register user
  Future<ApiResult<User>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    return await authService.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
  }

  /// Login user
  Future<ApiResult<User>> login({
    required String email,
    required String password,
  }) async {
    return await authService.login(email: email, password: password);
  }

  /// Login with social
  Future<ApiResult<User>> loginWithSocial({
    required String provider,
    required String accessToken,
  }) async {
    return await authService.loginWithSocial(
      provider: provider,
      accessToken: accessToken,
    );
  }

  /// Logout user
  Future<ApiResult<void>> logout() async {
    return await authService.logout();
  }

  /// Request password reset
  Future<ApiResult<void>> requestPasswordReset(String email) async {
    return await authService.requestPasswordReset(email);
  }

  /// Reset password
  Future<ApiResult<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return await authService.resetPassword(
      token: token,
      newPassword: newPassword,
    );
  }

  /// Change password
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  /// Get current user
  User? getCurrentUser() {
    return authService.currentUser;
  }

  /// Check if authenticated
  bool isAuthenticated() {
    return authService.isAuthenticated;
  }

  /// Get auth token
  String? getAuthToken() {
    return authService.authToken;
  }
}

class PaymentRepository {
  final PaymentService paymentService;

  PaymentRepository({required this.paymentService});

  /// Process payment
  Future<ApiResult<Payment>> processPayment({
    required String bookingId,
    required double amount,
    required String currency,
    required PaymentMethod method,
    PaymentCard? cardInfo,
  }) async {
    return await paymentService.processPayment(
      bookingId: bookingId,
      amount: amount,
      currency: currency,
      method: method,
      cardInfo: cardInfo,
    );
  }

  /// Get payment details
  Future<ApiResult<Payment>> getPaymentDetails(String paymentId) async {
    return await paymentService.getPaymentDetails(paymentId);
  }

  /// Refund payment
  Future<ApiResult<Payment>> refundPayment({
    required String paymentId,
    double? amount,
    String? reason,
  }) async {
    return await paymentService.refundPayment(
      paymentId: paymentId,
      amount: amount,
      reason: reason,
    );
  }

  /// Get payment history
  Future<ApiResult<List<Payment>>> getPaymentHistory() async {
    return await paymentService.getPaymentHistory();
  }

  /// Save payment method
  Future<ApiResult<String>> savePaymentMethod(PaymentCard card) async {
    return await paymentService.savePaymentMethod(card);
  }
}
