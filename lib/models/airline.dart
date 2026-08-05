class Airline {
  final String code;
  final String name;
  final String? logo;
  final String? alliance;

  Airline({
    required this.code,
    required this.name,
    this.logo,
    this.alliance,
  });

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      code: json['iataCode'] ?? json['code'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'],
      alliance: json['alliance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'logo': logo,
      'alliance': alliance,
    };
  }

  @override
  String toString() => '$name ($code)';
}
