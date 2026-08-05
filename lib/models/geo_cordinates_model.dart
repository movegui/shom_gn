class GeoCordinatesModel {
  final double? longitude;
  final double? latitude;

  GeoCordinatesModel({required this.longitude, required this.latitude});

  Map<String, dynamic> toJson() => {
    'longitude': longitude,
    'latitude': latitude,
  };

  factory GeoCordinatesModel.fromJson(Map<String, dynamic> json) =>
      GeoCordinatesModel(
        longitude: json['longitude'],
        latitude: json['latitude'],
      );
}
