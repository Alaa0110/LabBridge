class Clinic {
  final int id;
  final String name;
  final bool hasSpecialPrice;
  final String? taxNumber;

  Clinic({required this.id, required this.name, required this.hasSpecialPrice, this.taxNumber ,});

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'],
      name: json['name'],
      hasSpecialPrice: json['has_special_price'] == 1, // تحويل القيمة إلى boolean
      taxNumber: json['tax_number'],
    );
  }
}
