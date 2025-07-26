class AdminModel {
  Admin admin;
  Company company;

  AdminModel({required this.admin, required this.company});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      admin: Admin.fromJson(json['admin']),
      company: Company.fromJson(json['company']),
    );
  }
}

class Admin {
  int id;
  int subscriberId; // Add this property
  String firstName;
  String lastName;
  String email;

  Admin({
    required this.id,
    required this.subscriberId, // Initialize it
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      subscriberId: json['subscriber_id'], // Parse it
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }
}


class Company {
  int id;
  String companyName;
  String companyCode;
  String trialStartAt;
  String trialEndAt;

  Company({
    required this.id,
    required this.companyName,
    required this.companyCode,
    required this.trialStartAt,
    required this.trialEndAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyName: json['company_name'],
      companyCode: json['company_code'],
      trialStartAt: json['trial_start_at'],
      trialEndAt: json['trial_end_at'],
    );
  }
}