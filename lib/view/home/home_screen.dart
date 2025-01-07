// lib/views/success_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String companyCode = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Text('Company Code: $companyCode', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
