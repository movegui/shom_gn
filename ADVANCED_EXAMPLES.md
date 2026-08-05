# Travel App - Advanced Usage Examples

## Complete Booking Flow Example

```dart
// 1. Search for flights
final flightCriteria = FlightSearchCriteria(
  departureAirport: 'CDG',
  arrivalAirport: 'JFK',
  departureDate: DateTime(2024, 6, 15),
  returnDate: DateTime(2024, 6, 22),
  adults: 1,
  children: 1,
  cabin: 'ECONOMY',
  currency: 'USD',
  maxPrice: 2000,
);

final flightResult = await flightRepository.searchFlights(flightCriteria);

// 2. Filter and select cheapest flight
List<Flight> filteredFlights;
Flight selectedFlight;

flightResult.when(
  onSuccess: (flights) {
    filteredFlights = flightService.filterByPrice(flights, 500, 2000);
    selectedFlight = flightService.getCheapestFlight(filteredFlights)!;
  },
  onError: (error) => handleFlightError(error),
);

// 3. Search for hotels
final hotelCriteria = HotelSearchCriteria(
  city: 'New York',
  checkInDate: DateTime(2024, 6, 15),
  checkOutDate: DateTime(2024, 6, 22),
  rooms: 1,
  adults: 1,
  children: 1,
  currency: 'USD',
  minRating: 4.0,
);

final hotelResult = await hotelRepository.searchHotels(hotelCriteria);

// 4. Filter and select hotel
Hotel selectedHotel;
Room selectedRoom;

hotelResult.when(
  onSuccess: (hotels) {
    final filtered = hotelService.filterByRating(hotels, 4.5);
    selectedHotel = hotelService.getHighestRatedHotel(filtered)!;
    selectedRoom = selectedHotel.rooms.first;
  },
  onError: (error) => handleHotelError(error),
);

// 5. Create passengers
final passengers = [
  Passenger(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    dateOfBirth: DateTime(1990, 1, 1),
    type: PassengerType.adult,
    gender: Gender.male,
    email: 'john@example.com',
    phone: '+1234567890',
    passportNumber: 'AB123456',
    passportExpiry: DateTime(2030, 1, 1),
    nationality: 'US',
  ),
  Passenger(
    id: '2',
    firstName: 'Jane',
    lastName: 'Doe',
    dateOfBirth: DateTime(2015, 1, 1),
    type: PassengerType.child,
    gender: Gender.female,
    nationality: 'US',
  ),
];

// 6. Book flight
final flightBookingResult = await flightRepository.bookFlight(
  selectedFlight,
  passengers,
  paymentMethod: 'creditCard',
);

FlightBooking flightBooking;
flightBookingResult.when(
  onSuccess: (booking) {
    flightBooking = booking;
    print('Flight booked: ${booking.bookingReference}');
  },
  onError: (error) => handleBookingError(error),
);

// 7. Book hotel
final hotelBookingResult = await hotelRepository.bookHotel(
  selectedHotel,
  selectedRoom,
  DateTime(2024, 6, 15),
  DateTime(2024, 6, 22),
  passengers,
  paymentMethod: 'creditCard',
  specialRequests: 'High floor, city view',
);

HotelBooking hotelBooking;
hotelBookingResult.when(
  onSuccess: (booking) {
    hotelBooking = booking;
    print('Hotel booked: ${booking.bookingReference}');
  },
  onError: (error) => handleHotelBookingError(error),
);

// 8. Create combined booking
final combinedResult = await bookingRepository.createCombinedBooking(
  flightBooking: flightBooking,
  hotelBooking: hotelBooking,
);

// 9. Process payment
final paymentResult = await paymentRepository.processPayment(
  bookingId: 'combined_booking_id',
  amount: flightBooking.totalPrice.total + hotelBooking.totalPrice.total,
  currency: 'USD',
  method: PaymentMethod.creditCard,
  cardInfo: PaymentCard(
    cardNumber: '4111111111111111',
    cardholderName: 'John Doe',
    expiryMonth: '12',
    expiryYear: '2025',
    cvv: '123',
    billingAddress: '123 Main St',
    city: 'New York',
    postalCode: '10001',
    country: 'US',
  ),
);

// 10. Send confirmation
paymentResult.when(
  onSuccess: (payment) {
    if (payment.isSuccessful) {
      bookingRepository.sendConfirmationEmail(flightBooking.id);
      showSuccessMessage('Booking confirmed!');
    }
  },
  onError: (error) => showPaymentError(error),
);
```

## Advanced Filtering Example

```dart
// Complex flight filtering
Future<List<Flight>> findBestFlights(List<Flight> allFlights) async {
  // 1. Filter by price range
  var filtered = flightService.filterByPrice(allFlights, 500, 1500);
  
  // 2. Filter by duration (max 12 hours)
  filtered = flightService.filterByDuration(filtered, 720);
  
  // 3. Get direct flights only
  filtered = flightService.filterDirectFlights(filtered);
  
  // 4. Get top 5 cheapest
  filtered.sort((a, b) => a.price.total.compareTo(b.price.total));
  return filtered.take(5).toList();
}

// Advanced hotel filtering
Future<List<Hotel>> findBestHotels(List<Hotel> allHotels) async {
  // 1. Filter by minimum rating
  var filtered = hotelService.filterByRating(allHotels, 4.0);
  
  // 2. Filter by amenities
  filtered = hotelService.filterByAmenities(
    filtered,
    ['WiFi', 'Pool', 'Restaurant'],
  );
  
  // 3. Filter by price
  filtered = hotelService.filterByPrice(filtered, 100, 500);
  
  // 4. Sort by rating (highest first)
  filtered = hotelService.sortByRating(filtered, ascending: false);
  
  return filtered;
}
```

## Authentication Flow Example

```dart
// User Registration
Future<void> registerUser() async {
  final result = await authRepository.register(
    email: 'user@example.com',
    password: 'SecurePass123!',
    firstName: 'John',
    lastName: 'Doe',
    phoneNumber: '+1234567890',
  );

  result.when(
    onSuccess: (user) {
      print('User registered: ${user.email}');
      navigateToLogin();
    },
    onError: (error) {
      if (error is ValidationException) {
        showValidationError(error.message);
      } else {
        showError(error.message);
      }
    },
  );
}

// User Login
Future<void> loginUser() async {
  final result = await authRepository.login(
    email: 'user@example.com',
    password: 'SecurePass123!',
  );

  result.when(
    onSuccess: (user) {
      // Save user to cache
      userCache.saveCurrentUser(user);
      navigateToHome();
    },
    onError: (error) {
      if (error is UnauthorizedException) {
        showAuthError('Invalid credentials');
      } else {
        showError('Login failed');
      }
    },
  );
}

// Social Login
Future<void> loginWithGoogle(String googleToken) async {
  final result = await authRepository.loginWithSocial(
    provider: 'google',
    accessToken: googleToken,
  );

  result.when(
    onSuccess: (user) {
      userCache.saveCurrentUser(user);
      navigateToHome();
    },
    onError: (error) => showError('Social login failed'),
  );
}

// Password Reset Flow
Future<void> resetPassword(String email) async {
  // Step 1: Request reset
  final requestResult = await authRepository.requestPasswordReset(email);

  requestResult.when(
    onSuccess: (_) {
      showMessage('Check your email for reset link');
      navigateToResetCodeScreen();
    },
    onError: (error) {
      if (error is NotFoundException) {
        showError('Email not found');
      }
    },
  );
}

// Step 2: Confirm reset with code
Future<void> confirmPasswordReset(String token, String newPassword) async {
  final result = await authRepository.resetPassword(
    token: token,
    newPassword: newPassword,
  );

  result.when(
    onSuccess: (_) {
      showMessage('Password reset successfully');
      navigateToLogin();
    },
    onError: (error) {
      if (error is ValidationException) {
        showError('Invalid or expired reset code');
      }
    },
  );
}
```

## Booking Management Example

```dart
// Get user's bookings
Future<void> loadUserBookings() async {
  final result = await bookingRepository.getUserBookings();

  result.when(
    onSuccess: (bookings) {
      // Separate past and future bookings
      final now = DateTime.now();
      final futureBookings = bookings.where((b) {
        if (b.flightBooking != null) {
          return b.flightBooking!.departureDate!.isAfter(now);
        }
        if (b.hotelBooking != null) {
          return b.hotelBooking!.checkInDate.isAfter(now);
        }
        return false;
      }).toList();

      final pastBookings = bookings.where((b) {
        if (b.flightBooking != null) {
          return b.flightBooking!.departureDate!.isBefore(now);
        }
        if (b.hotelBooking != null) {
          return b.hotelBooking!.checkInDate.isBefore(now);
        }
        return false;
      }).toList();

      updateUI(futureBookings, pastBookings);
    },
    onError: (error) => showError('Failed to load bookings'),
  );
}

// Get booking details
Future<void> getBookingDetails(String bookingId) async {
  final result = await bookingRepository.getBookingDetails(bookingId);

  result.when(
    onSuccess: (booking) {
      if (booking.flightBooking != null) {
        showFlightDetails(booking.flightBooking!);
      }
      if (booking.hotelBooking != null) {
        showHotelDetails(booking.hotelBooking!);
      }
    },
    onError: (error) => showError('Failed to load booking'),
  );
}

// Search booking by reference
Future<void> searchByReference(String reference) async {
  final result = await bookingRepository.getBookingByReference(reference);

  result.when(
    onSuccess: (booking) => showBookingDetails(booking),
    onError: (error) {
      if (error is NotFoundException) {
        showError('Booking reference not found');
      }
    },
  );
}

// Cancel booking with refund
Future<void> cancelBooking(String bookingId) async {
  final bookingResult = await bookingRepository.getBookingDetails(bookingId);

  bookingResult.when(
    onSuccess: (booking) {
      // Get payment details
      if (booking.flightBooking != null && booking.flightBooking!.paymentDate != null) {
        // Refund payment
        paymentRepository.refundPayment(
          paymentId: booking.id,
          reason: 'Customer cancellation',
        ).then((refundResult) {
          refundResult.when(
            onSuccess: (_) {
              // Cancel booking after refund
              bookingRepository.cancelBooking(bookingId).then((cancelResult) {
                cancelResult.when(
                  onSuccess: (_) => showMessage('Booking cancelled and refunded'),
                  onError: (error) => showError('Failed to cancel booking'),
                );
              });
            },
            onError: (error) => showError('Failed to process refund'),
          );
        });
      }
    },
    onError: (error) => showError('Failed to load booking'),
  );
}
```

## Caching Example

```dart
// Search with cache support
Future<List<Flight>> searchFlightsWithCache(FlightSearchCriteria criteria) async {
  final cacheKey = '${criteria.departureAirport}_${criteria.arrivalAirport}_${criteria.departureDate}';

  // Try to get from cache first
  final cached = await flightCache.getSearchResults(cacheKey);
  if (cached != null) {
    print('Using cached results');
    return cached;
  }

  // If not in cache, fetch from API
  final result = await flightRepository.searchFlights(criteria);

  return result.when(
    onSuccess: (flights) {
      // Cache the results
      flightCache.saveSearchResults(cacheKey, flights);
      return flights;
    },
    onError: (error) {
      throw error;
    },
  );
}

// Clear cache when user logs out
Future<void> logoutAndClearCache() async {
  await authRepository.logout();
  await userCache.clearAll();
  await flightCache.clearAll();
  await hotelCache.clearAll();
  navigateToLogin();
}
```

## Date and Price Utilities Example

```dart
// Format dates for display
void displayFlightDates(Flight flight) {
  final departureFormatted = DateTimeUtils.formatDateTime(flight.departureTime);
  final arrivalFormatted = DateTimeUtils.formatDateTime(flight.arrivalTime);
  final duration = FlightUtils.getDurationString(flight.totalDuration);
  
  print('$departureFormatted → $arrivalFormatted ($duration)');
}

// Format prices
void displayPricing(Flight flight) {
  final priceFormatted = PriceUtils.formatPrice(flight.price.total, flight.price.currency);
  final discountedPrice = PriceUtils.calculateFinalPrice(flight.price.total, 10); // 10% discount
  
  print('Price: $priceFormatted');
  print('With 10% discount: ${PriceUtils.formatPrice(discountedPrice, flight.price.currency)}');
}

// Hotel pricing for stay duration
void displayHotelPricing(HotelBooking booking) {
  final totalCost = HotelUtils.getPricePerNightString(
    booking.room.price,
    booking.numberOfNights,
  );
  print('Total: $totalCost');
  
  final taxCalculated = PriceUtils.calculateTax(booking.room.price.total, 10); // 10% tax
  print('Tax: ${PriceUtils.formatPrice(taxCalculated, booking.room.price.currency)}');
}
```

## Validation Example

```dart
// Comprehensive form validation
class BookingFormValidator {
  static Map<String, String> validatePassengerForm({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String email,
    required String phone,
    required String passport,
  }) {
    final errors = <String, String>{};

    if (firstName.isEmpty) {
      errors['firstName'] = 'First name is required';
    }

    if (lastName.isEmpty) {
      errors['lastName'] = 'Last name is required';
    }

    if (email.isEmpty || !ValidationUtils.isValidEmail(email)) {
      errors['email'] = 'Valid email is required';
    }

    if (phone.isEmpty || !ValidationUtils.isValidPhone(phone)) {
      errors['phone'] = 'Valid phone is required';
    }

    if (passport.isEmpty || !ValidationRules.isValidPassport(passport)) {
      errors['passport'] = 'Valid passport is required';
    }

    return errors;
  }

  static Map<String, String> validatePaymentForm({
    required String cardNumber,
    required String cvv,
    required String expiryDate,
  }) {
    final errors = <String, String>{};

    if (!ValidationRules.isValidCardNumber(cardNumber)) {
      errors['cardNumber'] = 'Invalid card number';
    }

    if (!ValidationRules.isValidCVV(cvv)) {
      errors['cvv'] = 'Invalid CVV';
    }

    return errors;
  }
}
```

## Error Handling Best Practices

```dart
// Specific error handling
Future<void> handleApiError(Exception error) {
  if (error is NetworkException) {
    showError('Please check your internet connection');
  } else if (error is ServerException) {
    showError('Server error. Please try again later');
    logError('Server error: ${error.statusCode}');
  } else if (error is UnauthorizedException) {
    showError('Session expired. Please login again');
    navigateToLogin();
  } else if (error is ValidationException) {
    showError('Please check your input: ${error.message}');
  } else if (error is PaymentException) {
    showError('Payment failed: ${error.message}');
  } else if (error is TimeoutException) {
    showError('Request timed out. Please try again');
  } else {
    showError('An unexpected error occurred');
    logError('Unexpected error: $error');
  }
}
```
