import 'package:intl/intl.dart';
import '../models/models.dart';

class DateTimeUtils {
  /// Format date for display (e.g., "Jan 15, 2024")
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Format time for display (e.g., "2:30 PM")
  static String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  /// Format date and time together (e.g., "Jan 15, 2024 2:30 PM")
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy h:mm a').format(dateTime);
  }

  /// Format date for API (ISO 8601: "2024-01-15")
  static String formatDateForApi(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }

  /// Get relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      return '${(difference.inDays / 30).floor()} months ago';
    }
  }

  /// Get number of days between two dates
  static int getDaysDifference(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  /// Add days to a date
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is in past
  static bool isPastDate(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if date is in future
  static bool isFutureDate(DateTime date) {
    return date.isAfter(DateTime.now());
  }
}

class PriceUtils {
  /// Format price for display
  static String formatPrice(double price, String currency) {
    return '$currency ${price.toStringAsFixed(2)}';
  }

  /// Format price without decimals
  static String formatPriceShort(double price, String currency) {
    return '$currency ${price.toStringAsFixed(0)}';
  }

  /// Calculate discount
  static double calculateDiscount(double originalPrice, double discountPercentage) {
    return originalPrice * (discountPercentage / 100);
  }

  /// Calculate final price after discount
  static double calculateFinalPrice(double originalPrice, double discountPercentage) {
    return originalPrice - calculateDiscount(originalPrice, discountPercentage);
  }

  /// Calculate tax
  static double calculateTax(double price, double taxPercentage) {
    return price * (taxPercentage / 100);
  }

  /// Parse price string to double
  static double? parsePrice(String priceString) {
    try {
      return double.parse(priceString.replaceAll(RegExp(r'[^\d.]'), ''));
    } catch (e) {
      return null;
    }
  }
}

class StringUtils {
  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Capitalize each word
  static String capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) => capitalize(word))
        .join(' ');
  }

  /// Truncate string with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Remove special characters
  static String removeSpecialCharacters(String text) {
    return text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
  }

  /// Mask email (e.g., "j***@example.com")
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 1) {
      return '$username***@$domain';
    }

    final masked = username[0] + '*' * (username.length - 2) + username[username.length - 1];
    return '$masked@$domain';
  }

  /// Mask credit card (e.g., "**** **** **** 1234")
  static String maskCardNumber(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (cleaned.length < 4) return cleaned;

    final lastFour = cleaned.substring(cleaned.length - 4);
    return '**** **** **** $lastFour';
  }
}

class FlightUtils {
  /// Get flight duration in human-readable format
  static String getDurationString(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours == 0) {
      return '${minutes}m';
    } else if (minutes == 0) {
      return '${hours}h';
    } else {
      return '${hours}h ${minutes}m';
    }
  }

  /// Get number of stops string
  static String getStopsString(int stops) {
    if (stops == 0) return 'Non-stop';
    if (stops == 1) return '1 stop';
    return '$stops stops';
  }

  /// Check if flight time is early morning (5AM-9AM)
  static bool isEarlyMorning(DateTime time) {
    return time.hour >= 5 && time.hour < 9;
  }

  /// Check if flight time is morning (9AM-12PM)
  static bool isMorning(DateTime time) {
    return time.hour >= 9 && time.hour < 12;
  }

  /// Check if flight time is afternoon (12PM-5PM)
  static bool isAfternoon(DateTime time) {
    return time.hour >= 12 && time.hour < 17;
  }

  /// Check if flight time is evening (5PM-9PM)
  static bool isEvening(DateTime time) {
    return time.hour >= 17 && time.hour < 21;
  }

  /// Check if flight time is night (9PM-5AM)
  static bool isNight(DateTime time) {
    return time.hour >= 21 || time.hour < 5;
  }

  /// Get time period name
  static String getTimePeriod(DateTime time) {
    if (isEarlyMorning(time)) return 'Early Morning';
    if (isMorning(time)) return 'Morning';
    if (isAfternoon(time)) return 'Afternoon';
    if (isEvening(time)) return 'Evening';
    return 'Night';
  }

  /// Calculate layover time
  static String getLayoverTime(DateTime arrivalTime, DateTime nextDepartureTime) {
    final duration = nextDepartureTime.difference(arrivalTime);
    return DateTimeUtils.getRelativeTime(arrivalTime.subtract(duration));
  }

  /// Check if flight is refundable
  static bool isRefundable(Flight flight) {
    return flight.refundable;
  }
}

class HotelUtils {
  /// Get star rating display
  static String getStarRating(int? stars) {
    if (stars == null) return 'Not rated';
    return '★' * stars;
  }

  /// Get price per night string
  static String getPricePerNightString(Price price, int nights) {
    final total = price.total * nights;
    return '${price.currency} ${total.toStringAsFixed(2)} for $nights nights';
  }

  /// Check if hotel has free wifi
  static bool hasFreeWifi(Hotel hotel) {
    return hotel.amenities.any((a) => a.toLowerCase().contains('wifi') || a.toLowerCase().contains('internet'));
  }

  /// Check if hotel has pool
  static bool hasPool(Hotel hotel) {
    return hotel.amenities.any((a) => a.toLowerCase().contains('pool'));
  }

  /// Check if hotel has parking
  static bool hasParking(Hotel hotel) {
    return hotel.amenities.any((a) => a.toLowerCase().contains('parking'));
  }

  /// Get hotel quality indicator based on rating
  static String getQualityIndicator(double rating) {
    if (rating >= 4.5) return 'Excellent';
    if (rating >= 4.0) return 'Very Good';
    if (rating >= 3.5) return 'Good';
    if (rating >= 3.0) return 'Average';
    return 'Poor';
  }
}

class ValidationUtils {
  /// Validate email
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  /// Validate password (min 8 chars, uppercase, lowercase, number, special char)
  static bool isValidPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(password);
  }

  /// Validate phone number
  static bool isValidPhone(String phone) {
    return RegExp(r'^\+?1?\d{9,15}$').hasMatch(phone);
  }

  /// Get password strength indicator
  static String getPasswordStrength(String password) {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;
    if (RegExp(r'[a-z]').hasMatch(password) && RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'\d').hasMatch(password)) strength++;
    if (RegExp(r'[@$!%*?&]').hasMatch(password)) strength++;

    if (strength <= 1) return 'Weak';
    if (strength <= 2) return 'Fair';
    if (strength <= 3) return 'Good';
    if (strength <= 4) return 'Strong';
    return 'Very Strong';
  }
}
