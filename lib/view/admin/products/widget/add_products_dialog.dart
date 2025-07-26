import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/const_data/styles.dart';
import '../../../../../core/const_data/app_colors.dart';
import '../controller/prodect_controller.dart';

class AddProductDialog extends StatelessWidget {
  final int categoryId;

  AddProductDialog({super.key, required this.categoryId});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 10.h),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'اسم المنتج',
                  hintStyle: Styles.style16,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'السعر',
                  hintStyle: Styles.style16,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final price = double.tryParse(priceController.text.trim());

                  if (name.isNotEmpty && price != null && price > 0) {
                    productController.addProduct(name, categoryId, price);
                    Navigator.of(context).pop();
                  } else {
                    Get.snackbar('خطأ', 'يرجى إدخال بيانات صحيحة');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('إضافة المنتج'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
