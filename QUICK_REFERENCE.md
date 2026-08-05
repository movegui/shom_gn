# Travel App - Quick Reference Guide

## File Organization

```
lib/
├── models/
│   ├── airline.dart
│   ├── airport.dart
│   ├── api_response.dart
│   ├── booking.dart
│   ├── exceptions.dart
│   ├── flight.dart
│   ├── hotel.dart
│   ├── passenger.dart
│   ├── price.dart
│   ├── search_criteria.dart
│   ├── user.dart
│   └── models.dart (barrel export)
│
├── services/
│   ├── amadeus_api_service.dart
│   ├── auth_service.dart
│   ├── booking_service.dart
│   ├── cache_service.dart
│   ├── flight_service.dart
│   ├── hotel_service.dart
│   ├── payment_service.dart
│   └── services.dart (barrel export)
│
├── repositories/
│   └── repositories.dart
│
├── utils/
│   ├── constants.dart
│   └── utils.dart
│
└── main.dart
```

## Key Classes & Their Responsibilities

### Models

| Class | Purpose | Key Fields |
|-------|---------|-----------|
| `Airport` | Airport information | iataCode, name, city, country, location |
| `Airline` | Airline details | code, name, logo, alliance |
| `Price` | Pricing info | total, base, tax, currency |
| `Passenger` | Traveler details | firstName, lastName, dateOfBirth, type, passport |
| `Flight` | Flight offering | segments, price, departure/arrival, duration |
| `Segment` | Single flight leg | flightNumber, airline, airports, timing |
| `Hotel` | Hotel property | name, location, rating, amenities, rooms, price |
| `Room` | Hotel room | type, capacity, amenities, price, availability |
| `FlightBooking` | Flight reservation | flight, passengers, price, status, booking ref |
| `HotelBooking` | Hotel reservation | hotel, room, dates, guests, price, status |
| `CombinedBooking` | Package booking | flightBooking, hotelBooking, total price |
| `User` | User account | email, name, phone, preferences, payment methods |

### Services

| Service | Purpose | Key Methods |
|---------|---------|-----------|
| `AmadeusApiService` | Amadeus API client | searchFlights(), getAirports(), book() |
| `FlightService` | Flight operations | search, filter, compare, book, cancel |
| `HotelService` | Hotel operations | search, filter, sort, book, modify |
| `AuthService` | User authentication | login, register, logout, resetPassword |
| `BookingService` | Booking management | getBookings, create, update, cancel |
| `PaymentService` | Payment processing | processPayment, refund, getHistory |
| `InMemoryCacheService` | Local caching | saveData, getData, clearAll |

### Repositories

| Repository | Purpose |
|------------|---------|
| `FlightRepository` | Flight data access with caching |
| `HotelRepository` | Hotel data access with caching |
| `BookingRepository` | Booking data access |
| `AuthRepository` | Auth data access |
| `PaymentRepository` | Payment data access |

### Exceptions

| Exception | Use Case |
|-----------|----------|
| `NetworkException` | Connection errors |
| `ServerException` | Server errors (5xx) |
| `UnauthorizedException` | Auth failures (401) |
| `NotFoundException` | Resource not found (404) |
| `ValidationException` | Invalid input (400) |
| `PaymentException` | Payment failures (402) |
| `TimeoutException` | Request timeout |

### Response Types

| Response | Purpose |
|----------|---------|
| `SuccessResponse<T>` | Successful API response |
| `ErrorResponse<T>` | Failed API response |
| `LoadingResponse<T>` | Loading state |
| `PaginatedResponse<T>` | Paginated data |
| `ApiResult<T>` | Success or error with pattern matching |

## Common Enums

```dart
enum PassengerType { adult, child, infant }
enum Gender { male, female, other }
enum FlightStatus { active, pending, cancelled, completed }
enum RoomType { single, double, twin, suite, deluxe }
enum HotelStatus { available, booked, maintenance }
enum BookingStatus { pending, confirmed, cancelled, completed }
enum PaymentMethod { creditCard, debitCard, paypal, applePay, googlePay }
enum PaymentStatus { pending, processing, completed, failed, refunded }
```

## Utility Classes

```dart
DateTimeUtils       // Date formatting and calculations
PriceUtils          // Price calculations and formatting
StringUtils         // String manipulation
FlightUtils         // Flight-specific utilities
HotelUtils          // Hotel-specific utilities
ValidationUtils     // Input validation
ApiConstants        // API endpoints and config
AppStrings          // App-wide strings
ValidationRules     // Validation patterns and rules
```

## Common Usage Patterns

### Search Flights
```dart
final criteria = FlightSearchCriteria(
  departureAirport: 'CDG',
  arrivalAirport: 'JFK',
  departureDate: DateTime(2024, 6, 15),
  adults: 2,
);
final result = await flightRepository.searchFlights(criteria);
```

### Book Flight
```dart
final booking = await flightRepository.bookFlight(
  flight,
  passengers,
  paymentMethod: 'creditCard',
);
```

### Search Hotels
```dart
final criteria = HotelSearchCriteria(
  city: 'Paris',
  checkInDate: DateTime(2024, 6, 15),
  checkOutDate: DateTime(2024, 6, 20),
  rooms: 1,
  adults: 2,
);
final result = await hotelRepository.searchHotels(criteria);
```

### Process Payment
```dart
final payment = await paymentRepository.processPayment(
  bookingId: 'booking123',
  amount: 999.99,
  currency: 'USD',
  method: PaymentMethod.creditCard,
  cardInfo: card,
);
```

### Handle Results
```dart
result.when(
  onSuccess: (data) => print('Success: $data'),
  onError: (error) => print('Error: $error'),
);
```

## Important Constants

| Constant | Value | Purpose |
|----------|-------|---------|
| `defaultTimeout` | 30 seconds | Standard API timeout |
| `longTimeout` | 60 seconds | Payment/booking timeout |
| `shortTimeout` | 15 seconds | Quick operations |
| `defaultPageSize` | 10 | Pagination size |
| `minPasswordLength` | 8 | Password requirement |

## Error Handling Examples

```dart
// With pattern matching
try {
  final result = await repository.searchFlights(criteria);
  result.when(
    onSuccess: (flights) => handleFlights(flights),
    onError: (error) {
      if (error is NetworkException) {
        showNetworkError();
      } else if (error is ServerException) {
        showServerError();
      }
    },
  );
} catch (e) {
  handleUnexpectedError(e);
}
```

## Best Practices

1. **Always use repositories** instead of calling services directly
2. **Use ApiResult<T> pattern** for error handling
3. **Cache search results** for better UX
4. **Validate input** before API calls
5. **Handle exceptions** specific to the operation
6. **Dispose services** when done (close HTTP clients)
7. **Use enums** instead of strings for fixed values
8. **Format dates** using `DateTimeUtils` for consistency
9. **Validate prices** using `ValidationRules`
10. **Log errors** appropriately for debugging

## Integration Checklist

- [ ] Set Amadeus API credentials
- [ ] Configure backend API URL
- [ ] Set up database for persistent storage
- [ ] Implement caching strategy
- [ ] Add error logging
- [ ] Configure payment gateway
- [ ] Set up email service
- [ ] Add analytics
- [ ] Implement analytics tracking
- [ ] Set up crash reporting
