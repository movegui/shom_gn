class FooterConfigModel {
  final String address;
  final String phone;
  final String email;
  final String tva;
  final String nif;
  final String codeMarchant;
  final String name;
  final String supportEmail;
  final String supportPhone;

  FooterConfigModel({
    required this.address,
    required this.phone,
    required this.email,
    required this.tva,
    required this.nif,
    required this.codeMarchant,
    required this.name,
    required this.supportEmail,
    required this.supportPhone,
  });

  factory FooterConfigModel.fromJson(Map<String, dynamic> json) {
    return FooterConfigModel(
      address: json['shom.address'],
      phone: json['shom.phone'],
      email: json['shom.email'],
      tva: json['shom.TVA'],
      nif: json['shom.NIF'],
      codeMarchant: json['shom..code_marchant'],
      name: json['shom.name'],
      supportEmail: json['support.email'],
      supportPhone: json['support.phone']
    );
  }
}
