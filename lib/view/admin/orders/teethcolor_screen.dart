import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const_data/app_fonts.dart';
import '../tooth_color/controller/tooth_color_controller.dart';

class TeethColorsPage extends StatelessWidget {
  final TeethController teethController = Get.put(TeethController());

  TeethColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إختر لون الأسنان"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (teethController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (teethController.colors.isEmpty) {
          return const Center(
            child: Text(
              "لا يوجد ألوان متاحة.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عرض عنصرين في كل صف
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.2,
            ),
            itemCount: teethController.colors.length,
            itemBuilder: (context, index) {
              final color = teethController.colors[index];
              return GestureDetector(
                onTap: () {
                  Get.back(result: color['id']);
                },
                child: Card(
                  elevation: 4, // ظل خفيف
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      // اسم اللون
                      Text(
                        color['color'],
                        style: const TextStyle(
                          fontFamily: AppFonts.regular,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
