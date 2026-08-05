import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class AmadeusApiService {
  static const String baseUrl = 'https://api.amadeus.com/v2';
  
  final String clientId;
  final String clientSecret;
  final http.Client httpClient;

  String? _accessToken;
  DateTime? _tokenExpiry;

  AmadeusApiService({
    required this.clientId,
    required this.clientSecret,
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  /// Get access token for API authentication
  Future<String> getAccessToken() async {
    // Check if token is still valid
    if (_accessToken != null && _tokenExpiry != null && DateTime.now().isBefore(_tokenExpiry!)) {
      return _accessToken!;
    }

    try {
      final response = await httpClient.post(
        Uri.parse('${baseUrl.replaceAll('/v2', '')}/v1/security/oauth2/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
          'client_id': clientId,
          'client_secret': clientSecret,
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _accessToken = data['access_token'];
        _tokenExpiry = DateTime.now().add(Duration(seconds: data['expires_in'] ?? 1800));
        return _accessToken!;
      } else {
        throw ServerException(
          message: 'Failed to get access token',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(message: 'Failed to authenticate with Amadeus API: $e');
    }
  }

  /// Get authorization headers with token
  Future<Map<String, String>> _getHeaders() async {
    final token = await getAccessToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  /// Search for flights
  Future<ApiResult<List<Flight>>> searchFlights(FlightSearchCriteria criteria) async {
    try {
      final headers = await _getHeaders();
      final queryParams = criteria.toApiQuery();
      final uri = Uri.parse('$baseUrl/shopping/flight-offers').replace(
        queryParameters: queryParams.map((k, v) => MapEntry(k, v.toString())),
      );

      final response = await httpClient.get(uri, headers: headers).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final flights = (data['data'] as List?)
            ?.map((item) => Flight.fromJson(item))
            .toList() ?? [];
        return ApiResult.success(flights);
      } else if (response.statusCode == 401) {
        _accessToken = null; // Clear token for retry
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to search flights',
          statusCode: response.statusCode,
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Flight search failed: $e'));
    }
  }

  /// Get flight details
  Future<ApiResult<Flight>> getFlightDetails(String flightId) async {
    try {
      final headers = await _getHeaders();
      final response = await httpClient.get(
        Uri.parse('$baseUrl/shopping/flight-offers/$flightId'),
        headers: headers,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(Flight.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Flight not found');
      } else {
        throw ServerException(
          message: 'Failed to get flight details',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Get flight details failed: $e'));
    }
  }

  /// Get airport data
  Future<ApiResult<List<Airport>>> searchAirports(String keyword) async {
    try {
      final headers = await _getHeaders();
      final response = await httpClient.get(
        Uri.parse('$baseUrl/reference-data/locations').replace(
          queryParameters: {
            'keyword': keyword,
            'subType': 'AIRPORT,CITY',
          },
        ),
        headers: headers,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final airports = (data['data'] as List?)
            ?.map((item) => Airport.fromJson(item))
            .toList() ?? [];
        return ApiResult.success(airports);
      } else {
        throw ServerException(
          message: 'Failed to search airports',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Airport search failed: $e'));
    }
  }

  /// Get airport details by code
  Future<ApiResult<Airport>> getAirportByCode(String code) async {
    try {
      final headers = await _getHeaders();
      final response = await httpClient.get(
        Uri.parse('$baseUrl/reference-data/locations/$code'),
        headers: headers,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(Airport.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Airport not found');
      } else {
        throw ServerException(
          message: 'Failed to get airport details',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Get airport failed: $e'));
    }
  }

  /// Create flight booking
  Future<ApiResult<FlightBooking>> createFlightBooking(FlightBooking booking) async {
    try {
      final headers = await _getHeaders();
      final response = await httpClient.post(
        Uri.parse('$baseUrl/booking/flight-bookings'),
        headers: headers,
        body: jsonEncode(booking.toJson()),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(FlightBooking.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 400) {
        throw ValidationException(
          message: 'Invalid booking data',
          originalException: response.body,
        );
      } else {
        throw ServerException(
          message: 'Failed to create booking',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Create booking failed: $e'));
    }
  }

  /// Cancel flight booking
  Future<ApiResult<void>> cancelFlightBooking(String bookingId) async {
    try {
      final headers = await _getHeaders();
      final response = await httpClient.delete(
        Uri.parse('$baseUrl/booking/flight-bookings/$bookingId'),
        headers: headers,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 204 || response.statusCode == 200) {
        return ApiResult.success(null);
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Booking not found');
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

  void dispose() {
    httpClient.close();
  }
}
