import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../category/controller/category_controller.dart';
import '../clinics/controller/clinics_controller.dart';
import '../products/controller/prodect_controller.dart';
import 'controller/order_controller.dart';

class CategoryProductPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());
  final CreateOrderController orderController = Get.find<
      CreateOrderController>(); // ✅ الحصول على orderController
  final ClinicController clinicsController = Get.put(
      ClinicController()); // ✅ تسجيل الـ ClinicsController

  CategoryProductPage({super.key});


  String getSelectedClinicName() {
    final selectedClinic = clinicsController.clinics.firstWhereOrNull(
          (clinic) => clinic.id == orderController.clinicId.value,
    );
    return selectedClinic?.name ?? "لم يتم اختيار عيادة";
  }

  @override
  Widget build(BuildContext context) {
    categoryController.fetchCategories(); // Fetch categories on page load

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories & Products"),
      ),
      body: Column(
        children: [
          // ✅ عرض اسم العيادة المختارة بدلاً من القائمة المنسدلة
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: const Text("العيادة المختارة:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(getSelectedClinicName(),
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                  leading: const Icon(Icons.local_hospital, color: Colors.blue),
                ),
              ),
            );
          }),

          Expanded(
            child: Obx(() {
              if (categoryController.categories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.categories[index];

                  return ExpansionTile(
                    title: Text(category.name),
                    onExpansionChanged: (expanded) {
                      if (expanded) {
                        productController.fetchProductsByCategory(category.id);
                      }
                    },
                    children: [
                      Obx(() {
                        final products = productController
                            .productsByCategory[category.id] ?? [];
                        if (products.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("No products available."),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, productIndex) {
                            final product = products[productIndex];

                            // ✅ تحديث السعر الخاص عند تغيير العيادة
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              orderController.fetchClinicsWithSpecialPrice(
                                  product.id, orderController.clinicId.value);
                            });
                            return Obx(() {
                              final specialPrice = orderController.specialPrices[product.id]?.value;
                              final isLoading = orderController.isLoadingPrices.value; // ✅ تتبع حالة التحميل

                              return ListTile(
                                title: Text(product.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("السعر الأساسي: \$${product.price}", style: const TextStyle(fontSize: 14)),

                                    Obx(() {
                                      final specialPrice = orderController.specialPrices[product.id]?.value;
                                      return specialPrice != null && specialPrice > 0
                                          ? Text(
                                        "السعر الخاص: \$${specialPrice}",
                                        style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                                      )
                                          : const SizedBox.shrink();
                                    }),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.check_circle),
                                  onPressed: () {
                                    Get.back(result: product.id);
                                  },
                                ),
                              );
                            });
                          },
                        );
                      }),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}