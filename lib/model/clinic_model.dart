class Clinic {
  final int id;
  final String name;
  final bool hasSpecialPrice;
  final String? taxNumber; // Make taxNumber nullable
  final List<dynamic> doctors;

  Clinic({
    required this.id,
    required this.name,
    required this.hasSpecialPrice,
    this.taxNumber, // Allow null
    required this.doctors,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'] as int,
      name: json['name'] as String,
      hasSpecialPrice: (json['has_special_price'] as int) == 1,
      taxNumber: json['tax_number'] as String?,
      doctors: json['doctors'] as List<dynamic>,
    );
  }

}
