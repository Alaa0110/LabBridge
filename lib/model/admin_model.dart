// lib/models/admin_model.dart
import 'package:intl/intl.dart';
class Admin {
  final String firstName;
  final String lastName;
  final String companyCode;
  final DateTime trialStartDate;
  final DateTime trialEndDate;

  Admin({
    required this.firstName,
    required this.lastName,
    required this.companyCode,
    required String trialStartAt,
    required String trialEndAt,
  })  : trialStartDate = DateTime.parse(trialStartAt),
        trialEndDate = DateTime.parse(trialEndAt);

  // حساب الوقت المتبقي
  String get remainingDaysText {
    Duration remainingTime = trialEndDate.difference(DateTime.now());
    return remainingTime.inDays > 0
        ? ' ${remainingTime.inDays} '
        : 'فترتك التجريبية انتهت';
  }

  // تنسيق التاريخ
  String get formattedEndDate {
    return DateFormat('yyyy-MM-dd HH:mm').format(trialEndDate);
  }
}

