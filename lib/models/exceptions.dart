class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;
  final StackTrace? stackTrace;

  AppException({
    required this.message,
    this.code,
    this.originalException,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  NetworkException({
    required super.message,
    String? code,
    super.originalException,
    super.stackTrace,
  }) : super(
    code: code ?? 'NETWORK_ERROR',
  );
}

class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required super.message,
    this.statusCode,
    String? code,
    super.originalException,
    super.stackTrace,
  }) : super(
    code: code ?? 'SERVER_ERROR',
  );
}

class UnauthorizedException extends AppException {
  UnauthorizedException({
    required super.message,
    String? code,
    super.originalException,
    super.stackTrace,
  }) : super(
    code: code ?? 'UNAUTHORIZED',
  );
}

class NotFoundException extends AppException {
  NotFoundException({
    required super.message,
    String? code,
    super.originalException,
    super.stackTrace,
  }) : super(
    code: code ?? 'NOT_FOUND',
  );
}

class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  ValidationException({
    required super.message,
    String? code,
    this.fieldErrors,
    super.originalException,
    super.stackTrace,
  }) : super(
    code: code ?? 'VALIDATION_ERROR',
  );
}

class TimeoutException extends AppException {
  TimeoutException({
    required super.message,
    String? code,
    super.originalException,
    super.stackTrace,
  }) : super(
    code: code ?? 'TIMEOUT',
  );
}

class CacheException extends AppException {
  CacheException({
    required super.message,
    String? code,
    super.originalException,
    super.stackTrace,
  }) : super(
    code: code ?? 'CACHE_ERROR',
  );
}

class PaymentException extends AppException {
  final String? transactionId;

  PaymentException({
    required super.message,
    String? code,
    this.transactionId,
    super.originalException,
    super.stackTrace,
  }) : super(
    code: code ?? 'PAYMENT_ERROR',
  );
}

class ApiErrorResponse {
  final String? code;
  final String? title;
  final String? detail;
  final List<String>? errors;
  final Map<String, dynamic>? metadata;

  ApiErrorResponse({
    this.code,
    this.title,
    this.detail,
    this.errors,
    this.metadata,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      code: json['code'] ?? json['error_code'],
      title: json['title'] ?? json['error_title'],
      detail: json['detail'] ?? json['error_description'] ?? json['message'],
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
      metadata: json['metadata'],
    );
  }

  String get fullMessage => '$title: $detail';

  @override
  String toString() => fullMessage;
}
