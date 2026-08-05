enum PassengerType { adult, child, infant }

enum Gender { male, female, other }

class Passenger {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final PassengerType type;
  final Gender? gender;
  final String? email;
  final String? phone;
  final String? passportNumber;
  final DateTime? passportExpiry;
  final String? nationality;

  Passenger({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.type,
    this.gender,
    this.email,
    this.phone,
    this.passportNumber,
    this.passportExpiry,
    this.nationality,
  });

  String get fullName => '$firstName $lastName';

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: DateTime.parse(json['dateOfBirth'] ?? DateTime.now().toIso8601String()),
      type: PassengerType.values.byName(json['type'] ?? 'adult'),
      gender: json['gender'] != null ? Gender.values.byName(json['gender']) : null,
      email: json['email'],
      phone: json['phone'],
      passportNumber: json['passportNumber'],
      passportExpiry: json['passportExpiry'] != null ? DateTime.parse(json['passportExpiry']) : null,
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'type': type.name,
      'gender': gender?.name,
      'email': email,
      'phone': phone,
      'passportNumber': passportNumber,
      'passportExpiry': passportExpiry?.toIso8601String(),
      'nationality': nationality,
    };
  }

  @override
  String toString() => fullName;
}
