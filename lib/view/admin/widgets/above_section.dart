import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../controller/admin_controller.dart';

class AboveSection extends StatelessWidget {
  AboveSection({super.key});

  final adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
             const  Text(' رمز المعمل'),
              Obx(() {
                return Text(
                  adminController.companyCode.value,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                );
              }),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.blueAccent),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: adminController.companyCode.value),
                      );
                      Get.snackbar('نسخ', 'تم نسخ رمز المعمل إلى الحافظة');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.blueAccent),
                    onPressed: () {
                      Share.share(
                        '${adminController.companyCode.value} :هذا هو رمز المعمل الخاص بي',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            children: [
              const Text('الأيام المتبقية'),
              Obx(() {
                return Text(
                  adminController.remainingDays.value > 0
                      ? '${adminController.remainingDays.value}ايام '
                      : 'انتهت الفترة التجريبية',
                  style: TextStyle(
                    fontSize: 14,
                    color: adminController.remainingDays.value > 0
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
