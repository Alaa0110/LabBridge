class Doctor {
  final int id;
  final String firstName;
  final String lastName;
  final int clinicId;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.clinicId,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      clinicId: json['clinic_id'],
    );
  }

}
