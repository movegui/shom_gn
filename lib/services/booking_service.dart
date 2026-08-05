import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class BookingService {
  static const String baseUrl = 'https://api.example.com/v1'; // Replace with actual API

  final http.Client httpClient;
  final String? authToken;

  BookingService({
    http.Client? httpClient,
    this.authToken,
  }) : httpClient = httpClient ?? http.Client();

  /// Get all user bookings
  Future<ApiResult<List<CombinedBooking>>> getUserBookings() async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.get(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final bookings = (data['data'] as List?)
            ?.map((item) => CombinedBooking.fromJson(item))
            .toList() ?? [];
        return ApiResult.success(bookings);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to fetch bookings',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Fetch bookings failed: $e'));
    }
  }

  /// Get booking details by ID
  Future<ApiResult<CombinedBooking>> getBookingDetails(String bookingId) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.get(
        Uri.parse('$baseUrl/bookings/$bookingId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(CombinedBooking.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Booking not found');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to fetch booking details',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Fetch booking failed: $e'));
    }
  }

  /// Create combined flight and hotel booking
  Future<ApiResult<CombinedBooking>> createCombinedBooking({
    required FlightBooking flightBooking,
    required HotelBooking hotelBooking,
  }) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final booking = CombinedBooking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        flightBooking: flightBooking,
        hotelBooking: hotelBooking,
        totalPrice: Price(
          total: flightBooking.totalPrice.total + hotelBooking.totalPrice.total,
          base: flightBooking.totalPrice.base + hotelBooking.totalPrice.base,
          currency: flightBooking.totalPrice.currency,
        ),
        bookingDate: DateTime.now(),
      );

      final response = await httpClient.post(
        Uri.parse('$baseUrl/bookings/combined'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(booking.toJson()),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(CombinedBooking.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Invalid booking data');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to create combined booking',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Create booking failed: $e'));
    }
  }

  /// Cancel booking
  Future<ApiResult<void>> cancelBooking(String bookingId) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.delete(
        Uri.parse('$baseUrl/bookings/$bookingId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 204 || response.statusCode == 200) {
        return ApiResult.success(null);
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Booking not found');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to cancel booking',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Cancel booking failed: $e'));
    }
  }

  /// Update booking
  Future<ApiResult<CombinedBooking>> updateBooking(
    String bookingId,
    CombinedBooking booking,
  ) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.put(
        Uri.parse('$baseUrl/bookings/$bookingId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(booking.toJson()),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(CombinedBooking.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Booking not found');
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Invalid booking data');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to update booking',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Update booking failed: $e'));
    }
  }

  /// Get booking by reference
  Future<ApiResult<CombinedBooking>> getBookingByReference(String bookingReference) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.get(
        Uri.parse('$baseUrl/bookings/reference/$bookingReference'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(CombinedBooking.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Booking not found');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to fetch booking',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Fetch booking failed: $e'));
    }
  }

  /// Send booking confirmation email
  Future<ApiResult<void>> sendConfirmationEmail(String bookingId) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.post(
        Uri.parse('$baseUrl/bookings/$bookingId/send-confirmation'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResult.success(null);
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Booking not found');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to send confirmation email',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Send email failed: $e'));
    }
  }

  /// Get booking statistics
  Future<ApiResult<Map<String, dynamic>>> getBookingStats() async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.get(
        Uri.parse('$baseUrl/bookings/stats'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(data['stats'] ?? data);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to fetch statistics',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Fetch stats failed: $e'));
    }
  }

  void dispose() {
    httpClient.close();
  }
}
