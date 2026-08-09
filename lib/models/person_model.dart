

import 'package:shom_gn/models/address_model.dart';
import 'package:shom_gn/models/model.dart';
import 'package:uuid/uuid.dart';

class PersonModel extends Model {
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? profileImageUrl;
  final String? email;
  final String? phone;
  final String gender;
  final DateTime? birthDate;
   List<AddressModel?>? addresses;
  final String? nationality;

  PersonModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.profileImageUrl,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.addresses,
    this.nationality,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'firstName': firstName,
    'lastName': lastName,
    'middleName': middleName,
    'profileImageUrl': profileImageUrl,
    'email': email,
    'phone': phone,
    'gender': gender,
    'birthDate': birthDate?.toIso8601String() ?? '',
    'addresses': addresses
        ?.where((e) => e != null)
        .map((el) => el!.toJson())
        .toList(),
    'nationality': nationality,
  };

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: json['id'],
    name: json['name'],
    createdAt: json['createdAt'].toDate(),
    firstName: json['firstName'],
    lastName: json['lastName'],
    middleName: json['middleName'],
    profileImageUrl: json['profileImageUrl'],
    email: json['email'],
    phone: json['phone'],
    gender: json['gender'],
    birthDate: json['birthDate'] != null && !json['birthDate'].isEmpty
        ? DateTime.parse(json['birthDate'])
        : null,
    addresses: (json['addresses'] as List<dynamic>? ?? [])
        .map((e) {
          if (e is Map<String, dynamic>) {
            return AddressModel.fromJson(e);
          } else {
            print("Warning: invalid address entry: $e");
            return null;
          }
        })
        .where((e) => e != null)
        .cast<AddressModel>()
        .toList(),
    // addresses: (json['addresses'] as List? ?? []).map((e) => AddressModel.fromJson(e)).toList(),
    nationality: json['nationality'],
  );
  factory PersonModel.empty() => PersonModel(
    id: Uuid().v4(),
    name: '',
    createdAt: DateTime.now(),
    firstName: '',
    lastName: '',
    middleName: '',
    profileImageUrl: '',
    email: '',
    phone: '',
    gender: '',
    birthDate: DateTime(1800, 1, 1),
    addresses: [],
    nationality: '',
  );

  @override
  String toString() {
    return '$firstName $lastName ${email!} ${phone!}';
  }
}
