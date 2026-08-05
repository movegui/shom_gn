import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

enum PaymentMethod { creditCard, debitCard, paypal, applePay, googlePay }

enum PaymentStatus { pending, processing, completed, failed, refunded }

class PaymentCard {
  final String cardNumber;
  final String cardholderName;
  final String expiryMonth;
  final String expiryYear;
  final String cvv;
  final String? billingAddress;
  final String? city;
  final String? postalCode;
  final String? country;

  PaymentCard({
    required this.cardNumber,
    required this.cardholderName,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    this.billingAddress,
    this.city,
    this.postalCode,
    this.country,
  });

  String get maskedCardNumber => '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'cardholderName': cardholderName,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvv': cvv,
      'billingAddress': billingAddress,
      'city': city,
      'postalCode': postalCode,
      'country': country,
    };
  }
}

class Payment {
  final String id;
  final String bookingId;
  final double amount;
  final String currency;
  final PaymentMethod method;
  final PaymentStatus status;
  final DateTime createdAt;
  final String? transactionId;
  final String? failureReason;
  final PaymentCard? cardInfo;

  Payment({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.currency,
    required this.method,
    required this.status,
    required this.createdAt,
    this.transactionId,
    this.failureReason,
    this.cardInfo,
  });

  bool get isSuccessful => status == PaymentStatus.completed;
  bool get isPending => status == PaymentStatus.pending || status == PaymentStatus.processing;
  bool get isFailed => status == PaymentStatus.failed;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? '',
      bookingId: json['bookingId'] ?? '',
      amount: json['amount']?.toDouble() ?? 0,
      currency: json['currency'] ?? 'USD',
      method: PaymentMethod.values.byName(json['method'] ?? 'creditCard'),
      status: PaymentStatus.values.byName(json['status'] ?? 'pending'),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      transactionId: json['transactionId'],
      failureReason: json['failureReason'],
      cardInfo: json['cardInfo'] != null ? _parseCardInfo(json['cardInfo']) : null,
    );
  }

  static PaymentCard? _parseCardInfo(dynamic cardData) {
    if (cardData == null) return null;
    return PaymentCard(
      cardNumber: cardData['cardNumber'] ?? '',
      cardholderName: cardData['cardholderName'] ?? '',
      expiryMonth: cardData['expiryMonth'] ?? '',
      expiryYear: cardData['expiryYear'] ?? '',
      cvv: cardData['cvv'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'amount': amount,
      'currency': currency,
      'method': method.name,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'transactionId': transactionId,
      'failureReason': failureReason,
      'cardInfo': cardInfo?.toJson(),
    };
  }
}

class PaymentService {
  static const String baseUrl = 'https://api.example.com/v1'; // Replace with actual API

  final http.Client httpClient;
  final String? authToken;

  PaymentService({
    http.Client? httpClient,
    this.authToken,
  }) : httpClient = httpClient ?? http.Client();

  /// Process payment
  Future<ApiResult<Payment>> processPayment({
    required String bookingId,
    required double amount,
    required String currency,
    required PaymentMethod method,
    PaymentCard? cardInfo,
  }) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final requestBody = {
        'bookingId': bookingId,
        'amount': amount,
        'currency': currency,
        'method': method.name,
        if (cardInfo != null) 'cardInfo': cardInfo.toJson(),
      };

      final response = await httpClient.post(
        Uri.parse('$baseUrl/payments/process'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      ).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ApiResult.success(Payment.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Invalid payment details');
      } else if (response.statusCode == 402) {
        throw PaymentException(message: 'Payment failed - insufficient funds or declined');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Payment processing failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(PaymentException(message: 'Payment failed: $e'));
    }
  }

  /// Get payment details
  Future<ApiResult<Payment>> getPaymentDetails(String paymentId) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.get(
        Uri.parse('$baseUrl/payments/$paymentId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(Payment.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Payment not found');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to fetch payment details',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Fetch payment failed: $e'));
    }
  }

  /// Refund payment
  Future<ApiResult<Payment>> refundPayment({
    required String paymentId,
    double? amount, // Partial refund if specified
    String? reason,
  }) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final requestBody = {
        'paymentId': paymentId,
        if (amount != null) 'amount': amount,
        if (reason != null) 'reason': reason,
      };

      final response = await httpClient.post(
        Uri.parse('$baseUrl/payments/$paymentId/refund'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResult.success(Payment.fromJson(data['data'] ?? data));
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Payment not found');
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Cannot refund this payment');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Refund failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(PaymentException(message: 'Refund failed: $e'));
    }
  }

  /// Get payment history
  Future<ApiResult<List<Payment>>> getPaymentHistory() async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.get(
        Uri.parse('$baseUrl/payments'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final payments = (data['data'] as List?)
            ?.map((item) => Payment.fromJson(item))
            .toList() ?? [];
        return ApiResult.success(payments);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to fetch payment history',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Fetch payments failed: $e'));
    }
  }

  /// Save payment method
  Future<ApiResult<String>> savePaymentMethod(PaymentCard card) async {
    try {
      if (authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.post(
        Uri.parse('$baseUrl/payments/save-method'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(card.toJson()),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ApiResult.success(data['methodId'] ?? data['id'] ?? '');
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Invalid card information');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Authentication failed');
      } else {
        throw ServerException(
          message: 'Failed to save payment method',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Save payment method failed: $e'));
    }
  }

  void dispose() {
    httpClient.close();
  }
}
