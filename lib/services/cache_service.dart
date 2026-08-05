import '../models/models.dart';

/// Local cache service for storing data locally
abstract class CacheService {
  /// Save data to cache
  Future<void> saveData<T>(String key, T data, {Duration? expiresIn});

  /// Get data from cache
  Future<T?> getData<T>(String key, T Function(dynamic) fromJson);

  /// Remove data from cache
  Future<void> removeData(String key);

  /// Clear all cache
  Future<void> clearAll();

  /// Check if data exists
  Future<bool> hasKey(String key);

  /// Get cache size
  Future<int> getCacheSize();
}

class InMemoryCacheService implements CacheService {
  final Map<String, CacheEntry> _cache = {};
  final Duration defaultExpiry;

  InMemoryCacheService({this.defaultExpiry = const Duration(hours: 1)});

  @override
  Future<void> saveData<T>(String key, T data, {Duration? expiresIn}) async {
    _cache[key] = CacheEntry(
      data: data,
      timestamp: DateTime.now(),
      expiresAt: DateTime.now().add(expiresIn ?? defaultExpiry),
    );
  }

  @override
  Future<T?> getData<T>(String key, T Function(dynamic) fromJson) async {
    final entry = _cache[key];

    if (entry == null) {
      return null;
    }

    // Check if expired
    if (entry.expiresAt.isBefore(DateTime.now())) {
      _cache.remove(key);
      return null;
    }

    try {
      if (entry.data is T) {
        return entry.data as T;
      }
      return fromJson(entry.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> removeData(String key) async {
    _cache.remove(key);
  }

  @override
  Future<void> clearAll() async {
    _cache.clear();
  }

  @override
  Future<bool> hasKey(String key) async {
    if (!_cache.containsKey(key)) {
      return false;
    }

    final entry = _cache[key];
    if (entry != null && entry.expiresAt.isBefore(DateTime.now())) {
      _cache.remove(key);
      return false;
    }

    return true;
  }

  @override
  Future<int> getCacheSize() async {
    return _cache.length;
  }
}

class CacheEntry {
  final dynamic data;
  final DateTime timestamp;
  final DateTime expiresAt;

  CacheEntry({
    required this.data,
    required this.timestamp,
    required this.expiresAt,
  });

  bool get isExpired => expiresAt.isBefore(DateTime.now());
}

class FlightCache {
  static const String searchResultsKey = 'flight_search_results';
  static const String flightDetailsKey = 'flight_details_';
  static const String airportsKey = 'airports';
  static const String airlinesKey = 'airlines';

  final CacheService cacheService;

  FlightCache({required this.cacheService});

  /// Save flight search results
  Future<void> saveSearchResults(
    String searchQuery,
    List<Flight> flights,
  ) async {
    await cacheService.saveData(
      '$searchResultsKey:$searchQuery',
      flights.map((f) => f.toJson()).toList(),
    );
  }

  /// Get cached flight search results
  Future<List<Flight>?> getSearchResults(String searchQuery) async {
    final data = await cacheService.getData(
      '$searchResultsKey:$searchQuery',
      (json) => (json as List?)
          ?.map((item) => Flight.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
    return data;
  }

  /// Save flight details
  Future<void> saveFlightDetails(Flight flight) async {
    await cacheService.saveData(
      '$flightDetailsKey${flight.id}',
      flight.toJson(),
    );
  }

  /// Get cached flight details
  Future<Flight?> getFlightDetails(String flightId) async {
    return await cacheService.getData(
      '$flightDetailsKey$flightId',
      (json) => Flight.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Clear flight cache
  Future<void> clearAll() async {
    await cacheService.clearAll();
  }
}

class HotelCache {
  static const String searchResultsKey = 'hotel_search_results';
  static const String hotelDetailsKey = 'hotel_details_';
  static const String hotelReviewsKey = 'hotel_reviews_';

  final CacheService cacheService;

  HotelCache({required this.cacheService});

  /// Save hotel search results
  Future<void> saveSearchResults(
    String searchQuery,
    List<Hotel> hotels,
  ) async {
    await cacheService.saveData(
      '$searchResultsKey:$searchQuery',
      hotels.map((h) => h.toJson()).toList(),
    );
  }

  /// Get cached hotel search results
  Future<List<Hotel>?> getSearchResults(String searchQuery) async {
    final data = await cacheService.getData(
      '$searchResultsKey:$searchQuery',
      (json) => (json as List?)
          ?.map((item) => Hotel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
    return data;
  }

  /// Save hotel details
  Future<void> saveHotelDetails(Hotel hotel) async {
    await cacheService.saveData(
      '$hotelDetailsKey${hotel.id}',
      hotel.toJson(),
    );
  }

  /// Get cached hotel details
  Future<Hotel?> getHotelDetails(String hotelId) async {
    return await cacheService.getData(
      '$hotelDetailsKey$hotelId',
      (json) => Hotel.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Clear hotel cache
  Future<void> clearAll() async {
    await cacheService.clearAll();
  }
}

class UserCache {
  static const String currentUserKey = 'current_user';
  static const String bookingHistoryKey = 'booking_history';
  static const String userPreferencesKey = 'user_preferences';

  final CacheService cacheService;

  UserCache({required this.cacheService});

  /// Save current user
  Future<void> saveCurrentUser(User user) async {
    await cacheService.saveData(
      currentUserKey,
      user.toJson(),
      expiresIn: const Duration(hours: 24),
    );
  }

  /// Get cached current user
  Future<User?> getCurrentUser() async {
    return await cacheService.getData(
      currentUserKey,
      (json) => User.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Clear user cache
  Future<void> clearAll() async {
    await cacheService.removeData(currentUserKey);
    await cacheService.removeData(bookingHistoryKey);
    await cacheService.removeData(userPreferencesKey);
  }
}
