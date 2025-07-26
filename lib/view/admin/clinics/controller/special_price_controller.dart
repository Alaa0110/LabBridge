import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'clinics_controller.dart';


class SpecialPriceController extends GetxController {
  final ClinicController clinicController;
  final int productId;

  SpecialPriceController({
    required this.clinicController,
    required this.productId,
  });

  final RxList<int> selectedClinicIds = <int>[].obs;
  final RxMap<int, double> clinicsWithSpecialPrice = <int, double>{}.obs;
  final TextEditingController priceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchSpecialPriceClinics();
  }

  Future<void> fetchSpecialPriceClinics() async {
    await clinicController.fetchClinicsWithSpecialPrice(productId);
    final clinicsWithPrice = clinicController.clinicsWithSpecialPrice;
    clinicsWithSpecialPrice.value = {
      for (var clinic in clinicsWithPrice) clinic.clinicId: clinic.price,
    };
  }

  Future<void> addSpecialPrice() async {
    final price = double.tryParse(priceController.text.trim());
    if (selectedClinicIds.isEmpty || price == null || price <= 0) {
      Get.snackbar('خطأ', 'يرجى اختيار عيادة واحدة على الأقل وإدخال سعر صالح.');
      return;
    }

    await clinicController.addSpecialPrice(selectedClinicIds, productId, price);
    Get.back(); // Close the dialog after adding the special price.
  }
}
