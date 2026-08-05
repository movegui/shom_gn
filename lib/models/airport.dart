class Airport {
  final String iataCode;
  final String name;
  final String city;
  final String country;
  final double? latitude;
  final double? longitude;

  Airport({
    required this.iataCode,
    required this.name,
    required this.city,
    required this.country,
    this.latitude,
    this.longitude,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      iataCode: json['iataCode'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      country: json['countryCode'] ?? '',
      latitude: json['geoCode']?['latitude']?.toDouble(),
      longitude: json['geoCode']?['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iataCode': iataCode,
      'name': name,
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() => '$city ($iataCode)';
}
