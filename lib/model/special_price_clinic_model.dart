class SpecialPriceClinicResponse {
  final int id;
  final int productId;
  final int clinicId;
  final double price;
  final Clinic clinic;

  SpecialPriceClinicResponse({
    required this.id,
    required this.productId,
    required this.clinicId,
    required this.price,
    required this.clinic,
  });

  factory SpecialPriceClinicResponse.fromJson(Map<String, dynamic> json) {
    return SpecialPriceClinicResponse(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      clinicId: json['clinic_id'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      clinic: Clinic.fromJson(json['clinic'] ?? {}),
    );
  }
}
