import 'package:shom_gn/models/geo_cordinates_model.dart';
import 'package:shom_gn/models/model.dart';
import 'package:uuid/uuid.dart';

class AddressModel extends Model {
  final GeoCordinatesModel? geoCordinates;
  final String? zoneId;
  final String address;
  final String? district;
  final String minucipality;
  final String adressType;
  final int? zipCode;
  final String? ville;
  final String? pays;
  bool isDefault;
  AddressModel({
    this.geoCordinates,
    this.zoneId,
    required this.address,
    required super.id,
    required super.name,
    required super.createdAt,
    required this.district,
    required this.minucipality,
    required this.adressType,
    this.zipCode,
    this.ville,
    this.pays,
    this.isDefault = false,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'geoCordinates': geoCordinates?.toJson(),
    'zoneId': zoneId,
    'address': address,
    'district': district,
    'minucipality': minucipality,
    'adressType': adressType,
    'zipCode': zipCode,
    'ville': ville,
    'pays': pays,
    'isDefault': isDefault,
  };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    createdAt: json['createdAt'] != null
        ? json['createdAt'].toDate()
        : DateTime.now(),
    geoCordinates: json['geoCordinates'] != null
        ? GeoCordinatesModel.fromJson(json['geoCordinates'])
        : null,
    address: json['address'] ?? '',
    district: json['district'] ?? '',
    minucipality: json['minucipality'] ?? 'di',
    adressType: json['adressType'] ?? 'h',
    zipCode: json['zipCode'] ?? '',
    ville: json['ville'] ?? '',
    pays: json['pays'] ?? '',
    isDefault: json['isDefault'] ?? false,
  );

  String getMapAddress() {
    return '$address , $district, $minucipality, $ville, $pays';
  }

  static AddressModel getDaulftObject() => AddressModel(
    address: '',
    id: Uuid().v4(),
    name: '',
    createdAt: DateTime.now(),
    district: '',
    minucipality: 'di',
    geoCordinates: GeoCordinatesModel(longitude: 0.0, latitude: 0.0),
    adressType: 'h',
    isDefault: false,
  );

  static getCollectionName() {
    return 'adresses';
  }
}

class AddressType {
  static String HOME = 'h';
  static String OFFICE = 'o';
  static String NEIGHBOR = 'n';
  static String OTHER = 'ot';
}
