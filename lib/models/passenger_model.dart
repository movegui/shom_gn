import 'package:shom_gn/models/model.dart';
import 'package:shom_gn/models/person_model.dart';

enum PassengerType { adult, child, infant }

class PassengerModel extends Model {
  final String? passportNumber;
  final DateTime? passportExpiry;
  final PassengerType type;
  final PersonModel person;

  PassengerModel({
    this.passportNumber,
    this.passportExpiry,
    required this.type,
    required super.id,
    required super.name,
    required super.createdAt,
    required this.person,
  });

  String get fullName => '${person.firstName} ${person.lastName}';

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'].toDate(),
      type: PassengerType.values.byName(json['type'] ?? 'adult'),

      passportNumber: json['passportNumber'],
      passportExpiry: json['passportExpiry'] != null
          ? DateTime.parse(json['passportExpiry'])
          : null,
      person: PersonModel.fromJson(json['person']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'passportNumber': passportNumber,
    'passportExpiry': passportExpiry,
    'type': type.name,
    'person': person.toJson(),
  };

  @override
  String toString() => fullName;
}
