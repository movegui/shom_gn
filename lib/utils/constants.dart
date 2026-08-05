class ApiConstants {
  // API Base URLs
  static const String amadeusBaseUrl = 'https://api.amadeus.com/v2';
  static const String appBaseUrl = 'https://api.example.com/v1';

  // Amadeus API Endpoints
  static const String flightSearchEndpoint = '/shopping/flight-offers';
  static const String flightDetailsEndpoint = '/shopping/flight-offers';
  static const String airportSearchEndpoint = '/reference-data/locations';
  static const String hotelSearchEndpoint = '/shopping/hotel-offers';
  static const String hotelDetailsEndpoint = '/shopping/hotel-offers';
  static const String pointOfInterestEndpoint = '/reference-data/locations';

  // App API Endpoints
  static const String authLoginEndpoint = '/auth/login';
  static const String authRegisterEndpoint = '/auth/register';
  static const String authLogoutEndpoint = '/auth/logout';
  static const String bookingsEndpoint = '/bookings';
  static const String paymentsEndpoint = '/payments';

  // Request timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration longTimeout = Duration(seconds: 60);
  static const Duration shortTimeout = Duration(seconds: 15);

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 100;
  static const int defaultPage = 1;

  // Amadeus API Parameters
  static const String flightCabinEconomy = 'ECONOMY';
  static const String flightCabinPremiumEconomy = 'PREMIUM_ECONOMY';
  static const String flightCabinBusiness = 'BUSINESS';
  static const String flightCabinFirst = 'FIRST';

  // Common currencies
  static const String currencyUSD = 'USD';
  static const String currencyEUR = 'EUR';
  static const String currencyGBP = 'GBP';
  static const String currencyJPY = 'JPY';
  static const String currencyAUD = 'AUD';

  // Response codes
  static const int httpSuccess = 200;
  static const int httpCreated = 201;
  static const int httpNoContent = 204;
  static const int httpBadRequest = 400;
  static const int httpUnauthorized = 401;
  static const int httpForbidden = 403;
  static const int httpNotFound = 404;
  static const int httpConflict = 409;
  static const int httpServerError = 500;
  static const int httpServiceUnavailable = 503;

  // Cache durations
  static const Duration airportCacheDuration = Duration(hours: 24);
  static const Duration flightSearchCacheDuration = Duration(minutes: 15);
  static const Duration hotelSearchCacheDuration = Duration(minutes: 15);
  static const Duration userCacheDuration = Duration(hours: 1);

  // Amadeus OAuth2
  static const String amadeusAuthUrl = 'https://api.amadeus.com/v1/security/oauth2/token';
  static const String grantType = 'client_credentials';
}

class AppStrings {
  // Error messages
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String unauthorizedErrorMessage = 'You are not authorized. Please login again.';
  static const String notFoundErrorMessage = 'Resource not found.';
  static const String validationErrorMessage = 'Invalid input. Please check your data.';
  static const String timeoutErrorMessage = 'Request timed out. Please try again.';
  static const String cacheErrorMessage = 'Cache error. Please try again.';
  static const String paymentErrorMessage = 'Payment failed. Please try again.';

  // Success messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String logoutSuccessMessage = 'Logout successful!';
  static const String bookingSuccessMessage = 'Booking confirmed!';
  static const String paymentSuccessMessage = 'Payment successful!';
  static const String registrationSuccessMessage = 'Registration successful! Please login.';

  // General strings
  static const String noData = 'No data available';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String ok = 'OK';
  static const String close = 'Close';
}

class ValidationRules {
  // Email validation
  static final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Password validation rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  // Phone number validation
  static final phoneRegex = RegExp(r'^\+?1?\d{9,15}$');

  // Passport validation
  static final passportRegex = RegExp(r'^[A-Z0-9]{6,9}$');

  // Card number validation (basic)
  static final cardNumberRegex = RegExp(r'^\d{13,19}$');

  // CVV validation
  static final cvvRegex = RegExp(r'^\d{3,4}$');

  /// Validate email
  static bool isValidEmail(String email) {
    return emailRegex.hasMatch(email);
  }

  /// Validate password strength
  static bool isValidPassword(String password) {
    return passwordRegex.hasMatch(password);
  }

  /// Validate phone number
  static bool isValidPhone(String phone) {
    return phoneRegex.hasMatch(phone);
  }

  /// Validate passport number
  static bool isValidPassport(String passport) {
    return passportRegex.hasMatch(passport);
  }

  /// Validate card number
  static bool isValidCardNumber(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\s+'), '');
    return cardNumberRegex.hasMatch(cleaned);
  }

  /// Validate CVV
  static bool isValidCVV(String cvv) {
    return cvvRegex.hasMatch(cvv);
  }

  /// Validate dates for booking
  static bool isValidDateRange(DateTime startDate, DateTime endDate) {
    return endDate.isAfter(startDate);
  }

  /// Check if date is in future
  static bool isFutureDate(DateTime date) {
    return date.isAfter(DateTime.now());
  }
}
