import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../core/const_data/app_colors.dart';
import '../../../../../core/const_data/app_fonts.dart';
import '../../../core/const_data/styles.dart';
import '../../../model/product_model.dart';
import '../clinics/controller/clinics_controller.dart';
import '../clinics/special_price_screen.dart';
import 'controller/prodect_controller.dart';


class ProductsScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  final productController = Get.put(ProductController());


  ProductsScreen({super.key, required this.categoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Fetch products when the screen is loaded
    productController.fetchProductsByCategory(categoryId);

    final ClinicController clinicController = Get.find<ClinicController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الأصناف في $categoryName',
          style: const TextStyle(
            fontFamily: AppFonts.regular,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Obx(() {
        final products = productController.productsByCategory[categoryId] ?? [];

        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/empty.json', height: 200),
                const SizedBox(height: 20),
                const Text(
                  'لا يوجد منتجات مضافة',
                  style: TextStyle(
                    fontFamily: AppFonts.regular,
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  '"مثال" تاج زيركون',
                  style: TextStyle(
                    fontFamily: AppFonts.regular,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/images/product_teeth.svg',
                  height: 40,
                  width: 40,
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(
                    fontFamily: AppFonts.regular,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Obx(() {
                  final specialPrice = clinicController.clinicSpecialPrices[product.id];
                  return Text(
                    specialPrice != null
                        ? 'سعر خاص: ${specialPrice.toStringAsFixed(2)}'
                        : 'السعر: ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: AppFonts.regular,
                      fontSize: 16,
                    ),
                  );
                }),
                trailing: Container(

                  width: 100.w,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.local_offer, color: Colors.grey),
                        onPressed: () {
                          _showAddSpecialPriceDialog(context, product);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.grey),
                        onPressed: () {
                          _showEditProductDialog(context, product.id, product.price);
                        },
                      ),
                    ],
                  ),
                ),

              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog(context);
        },
        backgroundColor: AppColors.primaryLightColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<bool> _showConfirmDeleteDialog(BuildContext context, int productId) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا المنتج؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                productController.deleteProduct(productId,categoryId);
                Navigator.of(context).pop(true);
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _showAddProductDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showBarModalBottomSheet(
      context: context,
      builder: (context) {
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
                    decoration:  InputDecoration(hintText: 'اسم المنتج',hintStyle: Styles.style16,    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),),
                  ),
                   SizedBox(height: 10.h),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(hintText: 'السعر',hintStyle: Styles.style16,    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
            )),
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
      },
    );
  }

  void _showEditProductDialog(BuildContext context, int productId, double currentPrice) {
    // Convert the double price to a string for the TextEditingController
    final TextEditingController priceController = TextEditingController(text: currentPrice.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
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

                      // Validate input
                      final newPrice = double.tryParse(newPriceText);
                      if (newPrice == null || newPrice <= 0) {
                        Get.snackbar('خطأ', 'يرجى إدخال سعر صالح أكبر من 0');
                        return;
                      }

                      // Update the price using the controller
                      await productController.editPrice(productId, newPrice);
                      Navigator.of(context).pop();

                      // Refresh the product list
                      productController.fetchProductsByCategory(categoryId);
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
      },
    );
  }
  void _showAddSpecialPriceDialog(BuildContext context, Product product) {
    final clinicController = Get.find<ClinicController>();

    showDialog(
      context: context,
      builder: (context) {
        return AddSpecialPriceDialog(
          product: product,
          clinicController: clinicController,
        );
      },
    );
  }




}
