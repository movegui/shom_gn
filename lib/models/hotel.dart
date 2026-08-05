import 'price.dart';

enum RoomType { single, double, twin, suite, deluxe }

enum HotelStatus { available, booked, maintenance }

class Room {
  final String id;
  final RoomType type;
  final int capacity;
  final int numberOfBeds;
  final double squareMeters;
  final List<String> amenities;
  final List<String> images;
  final Price price;
  final int availableRooms;

  Room({
    required this.id,
    required this.type,
    required this.capacity,
    required this.numberOfBeds,
    required this.squareMeters,
    required this.amenities,
    required this.images,
    required this.price,
    required this.availableRooms,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] ?? '',
      type: RoomType.values.byName(json['type'] ?? 'single'),
      capacity: json['capacity'] ?? 2,
      numberOfBeds: json['numberOfBeds'] ?? 1,
      squareMeters: json['squareMeters']?.toDouble() ?? 0,
      amenities: List<String>.from(json['amenities'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      price: Price.fromJson(json['price'] ?? {}),
      availableRooms: json['availableRooms'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'capacity': capacity,
      'numberOfBeds': numberOfBeds,
      'squareMeters': squareMeters,
      'amenities': amenities,
      'images': images,
      'price': price.toJson(),
      'availableRooms': availableRooms,
    };
  }
}

class Hotel {
  final String id;
  final String name;
  final String description;
  final String address;
  final String city;
  final String country;
  final String postalCode;
  final double latitude;
  final double longitude;
  final double rating;
  final int numberOfReviews;
  final List<String> amenities;
  final List<String> images;
  final List<Room> rooms;
  final Price pricePerNight;
  final HotelStatus status;
  final String? website;
  final String? phone;
  final String? email;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final int? stars;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.numberOfReviews,
    required this.amenities,
    required this.images,
    required this.rooms,
    required this.pricePerNight,
    this.status = HotelStatus.available,
    this.website,
    this.phone,
    this.email,
    this.checkInTime,
    this.checkOutTime,
    this.stars,
  });

  String get location => '$city, $country';

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      postalCode: json['postalCode'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0,
      longitude: json['longitude']?.toDouble() ?? 0,
      rating: json['rating']?.toDouble() ?? 0,
      numberOfReviews: json['numberOfReviews'] ?? 0,
      amenities: List<String>.from(json['amenities'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      rooms: (json['rooms'] as List?)?.map((r) => Room.fromJson(r)).toList() ?? [],
      pricePerNight: Price.fromJson(json['pricePerNight'] ?? {}),
      status: HotelStatus.available,
      website: json['website'],
      phone: json['phone'],
      email: json['email'],
      stars: json['stars'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'numberOfReviews': numberOfReviews,
      'amenities': amenities,
      'images': images,
      'rooms': rooms.map((r) => r.toJson()).toList(),
      'pricePerNight': pricePerNight.toJson(),
      'status': status.name,
      'website': website,
      'phone': phone,
      'email': email,
      'stars': stars,
    };
  }

  @override
  String toString() => '$name - $location';
}
