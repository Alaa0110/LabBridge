// lib/models/technical_model.dart
class Technical {
  final int id;
  final String email;
  final bool isAvailable;
  final String firstName;
  final String lastName;

  Technical({
    required this.id,
    required this.email,
    required this.isAvailable,
    required this.firstName,
    required this.lastName,
  });

  factory Technical.fromJson(Map<String, dynamic> json) {
    return Technical(
      id: json['id'],
      email: json['email'],
      isAvailable: json['is_available'] == 1,
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
