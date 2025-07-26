import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/app_colors.dart';
import 'package:labbridge/view/admin/widgets/above_section.dart';
import '../../widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'controller/admin_controller.dart';
import 'drawer/drawer.dart';
import 'orders/create_order_screen.dart';
import 'orders/orders_screen.dart'; // Import your OrdersPage

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AdminController.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('لوحة التحكم'), centerTitle: true),
      drawer: const AdminDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => controller.screen[controller.selectedIndex.value]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateOrderPage()),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
