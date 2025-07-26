// lib/view/admin/admin_home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/admin_controller.dart';
import 'orders/orders_screen.dart';
import 'widgets/above_section.dart';
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AdminController.instance;

    return SingleChildScrollView(
      child: Column(
        children: [
          AboveSection(),
          const SizedBox(height: 16),
          // نضيف هنا OrdersListContent
          OrdersListContent(),
        ],
      ),
    );
  }
}



