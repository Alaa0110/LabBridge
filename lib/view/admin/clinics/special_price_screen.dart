import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:get/get.dart';
import '../../../core/const_data/app_colors.dart';
import '../../../model/product_model.dart';
import 'controller/clinics_controller.dart';

class AddSpecialPriceDialog extends StatefulWidget {
  final Product product;
  final ClinicController clinicController;

  const AddSpecialPriceDialog({
    Key? key,
    required this.product,
    required this.clinicController,
  }) : super(key: key);

  @override
  _AddSpecialPriceDialogState createState() => _AddSpecialPriceDialogState();
}

class _AddSpecialPriceDialogState extends State<AddSpecialPriceDialog> {
  final TextEditingController priceController = TextEditingController();
  final RxList<int> selectedClinicIds = <int>[].obs;

  @override
  void initState() {
    super.initState();
    // Fetch all clinics and then fetch those with special prices
    widget.clinicController.fetchClinics().then((_) {
      widget.clinicController.fetchClinicsWithSpecialPrice(widget.product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إضافة سعر خاص'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Multi-Select for Clinics
            Obx(() {
              final allClinics = widget.clinicController.clinics;
              final specialPriceClinics = widget.clinicController
                  .clinicsWithSpecialPrice;

              if (allClinics.isEmpty) {
                return const Text("لا توجد عيادات متاحة.");
              }

              // Merge and highlight clinics with special prices
              final items = allClinics.map((clinic) {
                final hasSpecialPrice = specialPriceClinics.any((
                    specialClinic) => specialClinic.id == clinic.id);
                return MultiSelectItem<int>(
                  clinic.id,
                  "${clinic.name}${hasSpecialPrice ? ' (سعر خاص)' : ''}",
                );
              }).toList();

              return MultiSelectDialogField<int>(
                items: items,
                title: const Text("اختر العيادات"),
                selectedColor: AppColors.primaryColor,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                buttonIcon: const Icon(Icons.arrow_drop_down),
                buttonText: const Text(
                  "اختر العيادات",
                  style: TextStyle(fontSize: 16),
                ),
                onConfirm: (values) {
                  selectedClinicIds.value = values;
                },
                initialValue: selectedClinicIds.value,
              );
            }),
            const SizedBox(height: 10),

            // TextField for Price
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'السعر الخاص',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            final selectedClinics = selectedClinicIds.value;
            final price = double.tryParse(priceController.text.trim());

            if (selectedClinics.isEmpty || price == null || price <= 0) {
              Get.snackbar('خطأ', 'يرجى إدخال بيانات صحيحة');
              return;
            }

            // Call the addSpecialPrice method in ClinicController
            widget.clinicController.addSpecialPrice(
              selectedClinics,
              widget.product.id,
              price,
            );

            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
          ),
          child: const Text('إضافة'),
        ),
      ],
    );
  }
}