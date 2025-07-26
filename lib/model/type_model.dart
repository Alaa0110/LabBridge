class TypeModel {
  final int id;
  final int subscriberId;
  final String type;
  final int invoiced;

  TypeModel({
    required this.id,
    required this.subscriberId,
    required this.type,
    required this.invoiced,
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      id: json['id'],
      subscriberId: json['subscriber_id'],
      type: json['type'],
      invoiced: json['invoiced'],
    );
  }
}
