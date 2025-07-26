import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../model/product_model.dart';
import '../../clinics/controller/clinics_controller.dart';
import '../controller/prodect_controller.dart';
import 'edit_product_dialog.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  ProductListItem({super.key, required this.product});

  final clinicController = Get.find<ClinicController>();
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
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
            fontFamily: 'RegularFont',
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
              fontFamily: 'RegularFont',
              fontSize: 16,
            ),
          );
        }),
        trailing: SizedBox(
          width: 100.w,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.local_offer, color: Colors.grey),
                onPressed: () {
                  // Implement special price dialog or action
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return EditProductDialog(
                        productId: product.id,
                        currentPrice: product.price,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
