class Price {
  final double total;
  final double base;
  final double? fees;
  final double? tax;
  final String currency;
  final double? perAdult;
  final double? perChild;
  final double? perInfant;

  Price({
    required this.total,
    required this.base,
    this.fees,
    this.tax,
    required this.currency,
    this.perAdult,
    this.perChild,
    this.perInfant,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      total: double.tryParse(json['grandTotal']?.toString() ?? '0') ?? 0,
      base: double.tryParse(json['base']?.toString() ?? '0') ?? 0,
      fees: json['fees'] != null ? double.tryParse(json['fees'].toString()) : null,
      tax: json['tax'] != null ? double.tryParse(json['tax'].toString()) : null,
      currency: json['currency'] ?? 'USD',
      perAdult: json['perAdult'] != null ? double.tryParse(json['perAdult'].toString()) : null,
      perChild: json['perChild'] != null ? double.tryParse(json['perChild'].toString()) : null,
      perInfant: json['perInfant'] != null ? double.tryParse(json['perInfant'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'base': base,
      'fees': fees,
      'tax': tax,
      'currency': currency,
      'perAdult': perAdult,
      'perChild': perChild,
      'perInfant': perInfant,
    };
  }

  String get formattedPrice => '$currency ${total.toStringAsFixed(2)}';

  @override
  String toString() => formattedPrice;
}
