import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../core/const_data/app_colors.dart';
import '../clinics/controller/clinics_controller.dart';
import '../../../model/product_model.dart';

class AddSpecialPriceDialog extends StatefulWidget {
  final Product product;
  final ClinicController clinicController;

  const AddSpecialPriceDialog({
    super.key,
    required this.product,
    required this.clinicController,
  });

  @override
  State<AddSpecialPriceDialog> createState() => _AddSpecialPriceDialogState();
}

class _AddSpecialPriceDialogState extends State<AddSpecialPriceDialog> {
  final TextEditingController _priceController = TextEditingController();
  List<int> _selectedClinicIds = [];
  Map<int, double> _clinicsWithSpecialPrice = {};

  @override
  void initState() {
    super.initState();
    _fetchSpecialPriceClinics();
  }

  Future<void> _fetchSpecialPriceClinics() async {
    await widget.clinicController.fetchClinicsWithSpecialPrice(widget.product.id);
    final clinicsWithPrice = widget.clinicController.clinicsWithSpecialPrice;
    setState(() {
      _clinicsWithSpecialPrice = {
        for (var clinic in clinicsWithPrice) clinic.clinicId: clinic.price,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'إضافة سعر خاص',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              if (widget.clinicController.clinics.isEmpty) {
                return const Text('لا توجد عيادات متاحة.');
              }

              return MultiSelectDialogField<int>(
                items: widget.clinicController.clinics.map((clinic) {
                  final specialPrice = _clinicsWithSpecialPrice[clinic.id];
                  final subtitle = specialPrice != null
                      ? ' (سعر خاص: ${specialPrice.toStringAsFixed(2)})'
                      : '';

                  return MultiSelectItem<int>(
                    clinic.id,
                    '${clinic.name}$subtitle',
                  );
                }).toList(),
                initialValue: _selectedClinicIds,
                title: const Text('اختيار العيادات'),
                selectedColor: AppColors.primaryColor,
                buttonText: const Text('حدد العيادات'),
                chipDisplay: MultiSelectChipDisplay(
                  chipColor: AppColors.primaryColor,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                searchable: true,
                searchHint: 'بحث...',
                onConfirm: (selected) {
                  setState(() {
                    _selectedClinicIds = selected;
                  });
                },
              );
            }),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'السعر الخاص',
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
          onPressed: () async {
            final price = double.tryParse(_priceController.text.trim());
            if (_selectedClinicIds.isEmpty || price == null || price <= 0) {
              Get.snackbar('خطأ', 'يرجى اختيار عيادة واحدة على الأقل وإدخال سعر صالح.');
              return;
            }

            await widget.clinicController.addSpecialPrice(
              _selectedClinicIds,
              widget.product.id,
              price,
            );

            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('إضافة'),
        ),
      ],
    );
  }
}