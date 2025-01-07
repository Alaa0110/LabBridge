class Specialization {
  final int id;
  final String name;

  Specialization({
    required this.id,
    required this.name,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['id'],
      name: json['name'],
    );
  }
}

class SpecializationWrapper {
  final int id;
  final int specializationsId;
  final int subscriberId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Specialization specialization;

  SpecializationWrapper({
    required this.id,
    required this.specializationsId,
    required this.subscriberId,
    required this.createdAt,
    required this.updatedAt,
    required this.specialization,
  });

  factory SpecializationWrapper.fromJson(Map<String, dynamic> json) {
    return SpecializationWrapper(
      id: json['id'],
      specializationsId: json['specializations_id'],
      subscriberId: json['subscriber_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      specialization: Specialization.fromJson(json['specialization']),
    );
  }
}
