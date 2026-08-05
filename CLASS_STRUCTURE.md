# Travel App Architecture - Class Structure

## Overview

This is a comprehensive travel booking application similar to Booking.com with Amadeus API integration. The project follows clean architecture principles with separation of concerns across different layers.

## Project Structure

```
lib/
├── models/              # Data models and entities
├── services/            # API services and business logic
├── repositories/        # Data access layer (Repository pattern)
├── utils/               # Utilities and constants
└── main.dart           # App entry point
```

## Models (`lib/models/`)

### Core Models

- **airport.dart** - `Airport` class for airport information
- **airline.dart** - `Airline` class for airline details
- **price.dart** - `Price` class for price information with currency
- **passenger.dart** - `Passenger` class for passenger details with enum `PassengerType` and `Gender`
- **flight.dart** - `Flight` and `Segment` classes for flight information
- **hotel.dart** - `Hotel`, `Room` classes with enum `RoomType` and `HotelStatus`
- **booking.dart** - `FlightBooking`, `HotelBooking`, `CombinedBooking` classes with enum `BookingStatus`
- **user.dart** - `User` and `UserPreferences` classes
- **search_criteria.dart** - `FlightSearchCriteria`, `HotelSearchCriteria`, `ReviewSearchCriteria` classes

### Exception & Response Models

- **exceptions.dart** - Custom exception classes:
  - `AppException` (base)
  - `NetworkException`
  - `ServerException`
  - `UnauthorizedException`
  - `NotFoundException`
  - `ValidationException`
  - `TimeoutException`
  - `CacheException`
  - `PaymentException`
  - `ApiErrorResponse`

- **api_response.dart** - Response wrappers:
  - `ApiResponse<T>` (abstract)
  - `SuccessResponse<T>`
  - `ErrorResponse<T>`
  - `LoadingResponse<T>`
  - `PaginatedResponse<T>`
  - `ApiResult<T>`

- **models.dart** - Barrel export file for all models

## Services (`lib/services/`)

### API Services

- **amadeus_api_service.dart** - `AmadeusApiService` for Amadeus API integration
  - Flight search and details
  - Airport search
  - Flight booking and cancellation
  - Token management

- **flight_service.dart** - `FlightService` wrapper around Amadeus API
  - Search, filter, compare flights
  - Get cheapest/fastest flights
  - Flight booking operations

- **hotel_service.dart** - `HotelService` for hotel operations
  - Search and filter hotels
  - Hotel booking and modifications
  - Reviews and ratings

- **auth_service.dart** - `AuthService` for authentication
  - User registration and login
  - Social login integration
  - Password reset and change
  - Token refresh

- **booking_service.dart** - `BookingService` for booking management
  - User bookings retrieval
  - Booking creation, updates, and cancellation
  - Confirmation emails
  - Booking statistics

- **payment_service.dart** - `PaymentService` for payments
  - Payment processing
  - Refunds and payment history
  - Payment method management
  - Enums: `PaymentMethod`, `PaymentStatus`
  - Models: `PaymentCard`, `Payment`

### Cache Service

- **cache_service.dart** - Local caching service
  - `CacheService` (interface)
  - `InMemoryCacheService` (implementation)
  - `FlightCache`, `HotelCache`, `UserCache` (specialized caches)
  - `CacheEntry` data structure

- **services.dart** - Barrel export file for all services

## Repositories (`lib/repositories/`)

- **repositories.dart** - Repository pattern implementations
  - `FlightRepository` - Flight data access
  - `HotelRepository` - Hotel data access
  - `BookingRepository` - Booking data access
  - `AuthRepository` - Authentication data access
  - `PaymentRepository` - Payment data access

## Utilities (`lib/utils/`)

- **constants.dart**
  - `ApiConstants` - API endpoints and configuration
  - `AppStrings` - App-wide string constants
  - `ValidationRules` - Input validation rules and regex patterns

- **utils.dart** - Helper utilities
  - `DateTimeUtils` - Date/time formatting and calculations
  - `PriceUtils` - Price calculations and formatting
  - `StringUtils` - String manipulation
  - `FlightUtils` - Flight-specific utilities
  - `HotelUtils` - Hotel-specific utilities
  - `ValidationUtils` - Input validation

## Key Features

### Authentication
- User registration and login
- Social authentication (Google, Facebook, etc.)
- Password reset and change
- JWT token management

### Flight Management
- Search flights with multiple criteria (passengers, dates, price range)
- Filter by price, duration, stops, airline
- Compare flight options
- Direct flight filtering
- Book flights with passenger details

### Hotel Management
- Search hotels by location and dates
- Filter by price, rating, amenities
- View hotel details and reviews
- Book hotels with guest information
- Modify and cancel bookings

### Booking System
- Combined flight and hotel bookings
- Booking history and details retrieval
- Booking status tracking
- Confirmation emails
- Booking cancellation with refunds

### Payment Processing
- Multiple payment methods (credit card, PayPal, etc.)
- Payment processing and status tracking
- Refund management
- Payment history
- Saved payment methods

### Caching
- In-memory caching for search results
- Cache expiration management
- Specialized caches for different data types

## Design Patterns Used

1. **Repository Pattern** - Data access abstraction
2. **Service Layer Pattern** - Business logic separation
3. **Factory Pattern** - JSON serialization/deserialization
4. **Exception Handling** - Custom exception hierarchy
5. **Result Type** - Functional error handling with `ApiResult<T>`
6. **Barrel Exports** - Organized imports with export files
7. **Enum Classes** - Type-safe enumerations
8. **Cache Pattern** - Data caching strategies

## API Integration

### Amadeus API
The app integrates with Amadeus Travel API for:
- Flight search and booking
- Airport information
- Airline data

### Custom Backend API
The app communicates with a custom backend for:
- User authentication
- Booking management
- Payment processing
- Hotel reservations

## Usage Example

```dart
// Initialize services
final amadeusService = AmadeusApiService(
  clientId: 'YOUR_CLIENT_ID',
  clientSecret: 'YOUR_CLIENT_SECRET',
);

final flightService = FlightService(apiService: amadeusService);
final flightRepository = FlightRepository(flightService: flightService);

// Search flights
final criteria = FlightSearchCriteria(
  departureAirport: 'CDG',
  arrivalAirport: 'JFK',
  departureDate: DateTime(2024, 6, 15),
  adults: 2,
  currency: 'USD',
);

final result = await flightRepository.searchFlights(criteria);

result.when(
  onSuccess: (flights) {
    print('Found ${flights.length} flights');
  },
  onError: (error) {
    print('Error: $error');
  },
);
```

## Error Handling

All API calls return `ApiResult<T>` which can be handled using pattern matching:

```dart
result.when(
  onSuccess: (data) => handleSuccess(data),
  onError: (error) => handleError(error),
);

// Or use maybeWhen for optional handling
result.maybeWhen(
  onSuccess: (data) => handleSuccess(data),
  orElse: () => handleDefault(),
);
```

## Validation

The app includes comprehensive validation for:
- Email addresses
- Passwords (strength requirements)
- Phone numbers
- Credit card numbers
- CVV codes
- Passport numbers
- Date ranges

## Future Enhancements

- Persistent storage with SQLite/Hive
- Advanced search filters
- Booking recommendations
- Travel insurance integration
- Multi-currency support
- Trip planning features
- Offline support
- Real-time notifications
- User reviews and ratings

## Notes

- All services dispose of HTTP clients properly
- Token expiration is handled automatically
- Cache entries expire based on configured duration
- API errors are mapped to specific exception types
- All JSON serialization is type-safe

## Architecture Diagram

```
┌─────────────────┐
│   UI Layer      │
└────────┬────────┘
         │
┌────────▼─────────────┐
│  Repository Layer    │
└────────┬─────────────┘
         │
┌────────▼─────────────┐
│  Service Layer       │
├──────────────────────┤
│ - Flight Service     │
│ - Hotel Service      │
│ - Auth Service       │
│ - Booking Service    │
│ - Payment Service    │
└────────┬─────────────┘
         │
┌────────▼─────────────┐
│  API Layer           │
├──────────────────────┤
│ - Amadeus API        │
│ - Custom Backend     │
└──────────────────────┘
```
