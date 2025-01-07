import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/class/crud.dart';
import '../../../../core/class/status_request.dart';
import '../../../../core/service/link.dart';
import '../../../../model/clinic_model.dart';
import '../../../../model/special_price_clinic_model.dart';
import '../../../../model/special_price_model.dart';

class ClinicController extends GetxController {
  final Crud crud = Crud();
  RxList<Clinic> clinics = <Clinic>[].obs;
  RxList<SpecialPrice> specialPriceList = <SpecialPrice>[].obs;
  RxBool hasSpecialPrice = false.obs;
  RxString currentClinicName = ''.obs;
  RxString currentTaxNumber = ''.obs;
  RxMap<int, double> clinicSpecialPrices = <int, double>{}.obs;
  RxList<Clinic> clinicsWithSpecialPrice = <Clinic>[].obs; // Separate list for special price clinics
  @override
  void onInit() {
    super.onInit();
    fetchClinics(); // Automatically fetch clinics when the controller is initialized
  }

  Future<void> fetchClinicsForDropdown() async {
    await fetchClinics(); // Uses the existing fetchClinics method to populate the clinics
  }

  Future<void> fetchSpecialPrices() async {
    // Simulate a delay to mimic API call
    await Future.delayed(Duration(seconds: 1));

    // Local test data
    final mockData = [
      SpecialPrice(
        id: 1,
        clinicName: "عيادة الأسنان الأولى",
        productName: "تاج زيركون",
        price: 150.0,
      ),
      SpecialPrice(
        id: 2,
        clinicName: "عيادة الابتسامة الجميلة",
        productName: "تقويم شفاف",
        price: 250.0,
      ),
      SpecialPrice(
        id: 3,
        clinicName: "عيادة الشفاء",
        productName: "حشو الأسنان",
        price: 75.0,
      ),
    ];

    // Assign mock data to the observable list
    specialPriceList.value = mockData;
  }
  Future<void> fetchClinicsWithSpecialPrice(int productId) async {
    try {
      final response = await crud.getData(
        "${AppLink.getClinicsWithSpecialPrice}/$productId",
        AppLink().getHeaderToken(),
      );

      response.fold(
            (error) {
          Get.snackbar("خطأ", "فشل في تحميل العيادات ذات الأسعار الخاصة.");
          clinicsWithSpecialPrice.clear(); // Clear list on error
        },
            (data) {
          if (data != null && data['clinics'] != null) {
            clinicsWithSpecialPrice.value = (data['clinics'] as List)
                .map((json) => SpecialPriceClinicResponse.fromJson(json))
                .map((response) => response.clinic)
                .toList();
          } else {
            // Handle case where 'clinics' key is null or missing
            clinicsWithSpecialPrice.clear();
            Get.snackbar("خطأ", "لم يتم العثور على عيادات ذات أسعار خاصة.");
          }
        },
      );
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ غير متوقع: $e.");
      print("Unexpected error: $e");
    }
  }




  void editSpecialPrice(int id, double newPrice) {
    final index = specialPriceList.indexWhere((price) => price.id == id);
    if (index != -1) {
      specialPriceList[index] = SpecialPrice(
        id: specialPriceList[index].id,
        clinicName: specialPriceList[index].clinicName,
        productName: specialPriceList[index].productName,
        price: newPrice,
      );
      specialPriceList.refresh(); // Notify listeners about the change
      Get.snackbar("نجاح", "تم تعديل السعر بنجاح.");
    }
  }

  void deleteSpecialPrice(int id) {
    specialPriceList.removeWhere((price) => price.id == id);
    Get.snackbar("نجاح", "تم حذف السعر بنجاح.");
  }

  // Add Special Price
  Future<void> addSpecialPrice(List<int> clinicIds, int productId, double price) async {
    try {
      // Validate inputs
      if (clinicIds.isEmpty) {
        Get.snackbar("خطأ", "يجب اختيار عيادة واحدة على الأقل.");
        return;
      }
      if (price <= 0) {
        Get.snackbar("خطأ", "السعر الخاص يجب أن يكون أكبر من 0.");
        return;
      }

      final body = {
        "clinic_ids": clinicIds,
        "product_id": productId,
        "price": price.toStringAsFixed(2), // Ensure consistent decimal places
      };

      final response = await crud.postData(
        AppLink.addSpecialPrice,
        body,
        AppLink().getHeaderToken(),
      );

      response.fold(
            (error) {
          Get.snackbar("خطأ", "فشل إضافة السعر الخاص.");
        },
            (data) {
          // Optionally refresh special prices list or show success
          Get.snackbar("نجاح", "تم إضافة السعر الخاص بنجاح.");
        },
      );
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ غير متوقع: $e.");
    }
  }




Future<void> fetchClinics() async {
    // Wrap in try-finally to ensure loading state is handled
    try {
      final response = await crud.getData(
          AppLink.showClinics, AppLink().getHeaderToken());

      response.fold(
            (error) {
          Get.snackbar("خطأ", "فشل تحضير العيادات , تأكد من اتصالك بالإنترنت.");
        },
            (data) {
          if (data.containsKey('clinics')) {
            clinics.value = (data['clinics'] as List)
                .map((json) => Clinic.fromJson(json))
                .toList();
          } else {
            Get.snackbar("خطأ", "لم يتم إيجاد عيادات.");
          }
        },
      );
    } catch (e) {
      Get.snackbar("خطأ", "خطأ غير متوقع.");
    } finally {

    }
  }




  Future<int?> addClinic(String name, bool hasSpecialPrice, String taxNumber) async {
    try {
      final body = {
        "name": name,
        "has_special_price": hasSpecialPrice ? '1' : '0',
        "tax_number": taxNumber,
      };

      final response = await crud.postData(
          AppLink.addClinics, body, AppLink().getHeaderToken());

      return response.fold(
            (error) {
          Get.snackbar("خطأ", "فشل إضافة العيادة.");
          return null; // Indicate failure by returning null
        },
            (data) {
          fetchClinics(); // Refresh clinics list
          Get.snackbar("نجاح", "تم إضافة العيادة بنجاح");
          return data['clinic_id']; // Replace with actual key returned from API
        },
      );
    } catch (e) {
      Get.snackbar("خطأ", "خطأ غير متوقع.");
      return null; // Indicate failure by returning null
    }
  }





  // Edit Clinic
  Future<void> editClinic(
      int id, String name, bool hasSpecialPrice, String? taxNumber) async {
    try {
      final body = {
        "name": name,
        "has_special_price": hasSpecialPrice ? '1' : '0', // Corrected mapping
      };

      if (taxNumber != null) {
        body["tax_number"] = taxNumber;
      }

      final response = await crud.putData(
          "${AppLink.editClinics}/$id", body, AppLink().getHeaderToken());

      response.fold(
            (error) {
          switch (error) {
            case StatusRequest.offlineFailure:
              Get.snackbar("خطأ", "لا يوجد اتصال بالإنترنت.");
              break;
            case StatusRequest.timeout:
              Get.snackbar("خطأ", "انتهى وقت الطلب، حاول مرة أخرى.");
              break;
            default:
              Get.snackbar("خطأ", "فشل تعديل العيادة، حاول مرة أخرى.");
              break;
          }
        },
            (data) {
          fetchClinics(); // Refresh clinics list
          Get.snackbar("نجاح", 'تم تعديل العيادة بنجاح.');
        },
      );
    } catch (e) {
      Get.snackbar("خطأ", "خطأ غير متوقع.");
    }
  }


  // Delete Clinic
  Future<void> deleteClinic(int id) async {
    try {
      final response = await crud.deleteData(
          "${AppLink.deleteClinics}/$id", AppLink().getHeaderToken());

      response.fold(
            (error) => Get.snackbar("خطأ", "فشل في حذف العيادة."),
            (data) {
          fetchClinics(); // Refresh clinics list after deletion
          Get.snackbar("نجاح", "تم حذف العيادة بنجاح");
        },
      );
    } catch (e) {
      Get.snackbar("خطأ", "خطأ غير متوقع.");
    }
  }

  // Reset Form Fields
  void resetClinicForm() {
    currentClinicName.value = '';
    currentTaxNumber.value = '';
    hasSpecialPrice.value = false;
  }

  // Prepare for Editing
  void prepareEditClinic(Clinic clinic) {
    currentClinicName.value = clinic.name;
    currentTaxNumber.value = clinic.taxNumber ?? '';
    hasSpecialPrice.value = clinic.hasSpecialPrice;
  }

  // Update Special Price State
  void updateSpecialPrice(bool value) {
    hasSpecialPrice.value = value;
  }
  Future<void> showConfirmDeleteDialog(BuildContext context, int clinicId) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذه العيادة؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                deleteClinic(clinicId);
                Navigator.of(context).pop(true);
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }



}
