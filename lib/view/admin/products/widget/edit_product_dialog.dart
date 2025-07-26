import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/const_data/app_colors.dart';
import '../controller/prodect_controller.dart';

class EditProductDialog extends StatelessWidget {
  final int productId;
  final double currentPrice;

  EditProductDialog({super.key, required this.productId, required this.currentPrice});

  final TextEditingController priceController = TextEditingController();
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    priceController.text = currentPrice.toString();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'تعديل السعر',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final newPriceText = priceController.text.trim();
                  final newPrice = double.tryParse(newPriceText);

                  if (newPrice == null || newPrice <= 0) {
                    Get.snackbar('خطأ', 'يرجى إدخال سعر صالح أكبر من 0');
                    return;
                  }

                  await productController.editPrice(productId, newPrice);
                  Navigator.of(context).pop();
                  productController.fetchProductsByCategory(productController.currentCategoryId as int);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('حفظ التعديلات'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
