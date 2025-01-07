class SpecialPrice {
  final int id;
  final String clinicName;
  final String productName;
  final double price;

  SpecialPrice({
    required this.id,
    required this.clinicName,
    required this.productName,
    required this.price,
  });

  factory SpecialPrice.fromJson(Map<String, dynamic> json) {
    return SpecialPrice(
      id: json['id'],
      clinicName: json['clinic_name'],
      productName: json['product_name'],
      price: json['price'].toDouble(),
    );
  }
}
