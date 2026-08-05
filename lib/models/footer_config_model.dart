class FooterConfigModel {
  final String address;
  final String phone;
  final String email;

  FooterConfigModel({
    required this.address,
    required this.phone,
    required this.email,
  });

  factory FooterConfigModel.fromJson(Map<String, dynamic> json) {
    return FooterConfigModel(
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}