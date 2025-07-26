import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/class/crud.dart';
import '../../../../core/class/status_request.dart';
import '../../../../core/service/link.dart';
import '../../../../model/clinic_model.dart';
import '../../../../model/special_price_clinic_model.dart';

class ClinicController extends GetxController {
  RxBool isLoading = true.obs;
  final Crud crud = Crud();
  var clinics = <Clinic>[].obs;
  RxBool hasSpecialPrice = false.obs;
  RxString currentClinicName = ''.obs;
  RxString currentTaxNumber = ''.obs;
  RxMap<int, double> clinicSpecialPrices = <int, double>{}.obs;
  RxList<SpecialPriceClinicResponse> clinicsWithSpecialPrice = <SpecialPriceClinicResponse>[].obs; // Separate list for special price clinics
  @override
  void onInit() {
    super.onInit();
    fetchClinics();
  }


  Future<void> fetchClinicsForDropdown() async {
    await fetchClinics(); // Uses the existing fetchClinics method to populate the clinics
  }

  Future<void> fetchClinicsWithSpecialPrice(int productId, [int? clinicId]) async {
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
                .map((json) => SpecialPriceClinicResponse.fromJson(json)).cast<SpecialPriceClinicResponse>()
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
    isLoading.value = true;
    print("Fetching clinics..."); // Start log
    try {
      final response = await crud.getData(AppLink.showClinics, AppLink().getHeaderToken());
      response.fold(
            (error) {
          print("Error fetching clinics: $error"); // Error log
          Get.snackbar("خطأ", "فشل تحميل العيادات");
        },
            (data) {
          if (data != null && data['clinics'] != null) {
            clinics.value = (data['clinics'] as List)
                .map((json) => Clinic.fromJson(json))
                .toList();
            print("Clinics loaded: ${clinics.length}"); // Success log
          } else {
            print("No clinics found in response."); // No clinics log
            clinics.clear();
            Get.snackbar("خطأ", "لم يتم العثور على عيادات.");
          }
        },
      );
    } catch (e) {
      print("Unexpected error: $e"); // Exception log
      clinics.clear();
      Get.snackbar("خطأ", "خطأ غير متوقع.");
    } finally {
      isLoading.value = false;
      clinics.refresh(); // Ensure UI refresh
      print("Clinics fetch complete. Total clinics: ${clinics.length}"); // Completion log
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