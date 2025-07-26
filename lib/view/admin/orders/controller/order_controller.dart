// File: lib/controller/order_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/class/crud.dart';
import '../../../../core/service/link.dart';
import '../../../../core/service/services.dart';
import '../../../../core/service/shared_perfrences_key.dart';
import '../../../../model/order_model.dart';
import '../../../../model/special_price_clinic_model.dart';
import '../../../../model/specialization_model.dart';
import 'package:http/http.dart' as http;
import '../../../../widgets/loading_widget.dart';

class CreateOrderController extends GetxController {
  final Crud crud = Crud();
  final MyServices myServices = Get.find();

  var specializationSubscriberId = 0.obs;
  var specializations = <Specialization>[].obs;
  var doctorId = 0.obs;
  var productId = 0.obs;
  var clinicId = 0.obs;
  var toothColorId = 0.obs;
  RxList<String> teethNumbers = <String>[].obs;
  var status = "pending".obs;
  var type = "new".obs;

  var orders = <Order>[].obs;
  var filteredOrders = <Order>[].obs;
  var isLoading = false.obs;
  var hasMore = true;
  var currentPage = 1.obs;
  var scrollController = ScrollController();
  var fromDate = DateTime(1900, 1, 1).obs;
  var toDate = DateTime.now().obs;
  var showDateFilter = false.obs;
  var isDateFilterActive = false.obs;
  var selectedTypeFilter = "all".obs;
  var selectedStatusFilter = "all".obs;

  RxMap<int, Rxn<double>> specialPrices = <int, Rxn<double>>{}.obs;
  var specialPrice = Rxn<double>();
  var isLoadingPrices = false.obs;

  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController receiveDateController = TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();
  final TextEditingController patientIdController = TextEditingController();
  final TextEditingController note = TextEditingController();

  @override
  void onInit() {
    fetchSpecializations();
    ever(clinicId, (_) {
      if (productId.value != 0) {
        fetchClinicsWithSpecialPrice(productId.value, clinicId.value);
      }
    });
    scrollController.addListener(_scrollListener);
    fetchOrders();
    super.onInit();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 &&
        !isLoading.value && hasMore) {
      fetchOrders(loadMore: true);
    }
  }

  void filterBySearch(String query) {
    query = query.trim().toLowerCase();
    if (query.isEmpty) {
      filteredOrders.assignAll(orders);
    } else {
      filteredOrders.assignAll(
        orders.where((order) => order.patientName.toLowerCase().contains(query)),
      );
    }
  }

  Future<void> fetchOrders({bool loadMore = false}) async {
    if (isDateFilterActive.value) {
      await fetchOrdersWithDateRange(loadMore: loadMore);
    } else {
      await fetchRegularOrders(loadMore: loadMore);
    }
    filteredOrders.assignAll(orders);
  }

  Future<void> fetchRegularOrders({bool loadMore = false}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    if (!loadMore) {
      currentPage.value = 1;
      orders.clear();
    }

    String url;
    if (selectedStatusFilter.value != "all") {
      url = "${AppLink.getOrdersByStatus}/${selectedStatusFilter.value}?page=${currentPage.value}";
    } else {
      url = "${AppLink.getOrder}/${selectedTypeFilter.value}?page=${currentPage.value}";
    }
    final response = await crud.getData(url, AppLink().getHeaderToken());
    response.fold(
          (error) => Get.snackbar("Error", "Failed to load orders"),
          (data) {
        final List<Order> fetchedOrders = (data['data'] as List).map((e) => Order.fromJson(e)).toList();
        orders.addAll(fetchedOrders);
        hasMore = data['next_page_url'] != null;
        if (hasMore) currentPage.value++;
      },
    );
    isLoading.value = false;
  }

  Future<void> fetchOrdersWithDateRange({bool loadMore = false}) async {
    if (isLoading.value) return;
    isLoading.value = true;

    if (!loadMore) {
      currentPage.value = 1;
      orders.clear();
    }

    final response = await crud.postData(
      AppLink.fromToOrders,
      {
        "from_date": fromDate.value.toString().split(' ')[0],
        "to_date": toDate.value.toString().split(' ')[0],
      },
      AppLink().getHeaderToken(),
    );

    response.fold(
          (error) => Get.snackbar("خطأ", "فشل تحميل الطلبات بالتاريخ", backgroundColor: Colors.red, colorText: Colors.white),
          (data) {
        final List<Order> fetchedOrders = (data['data'] as List).map((e) => Order.fromJson(e)).toList();
        orders.addAll(fetchedOrders);
        hasMore = data['next_page_url'] != null;
        if (hasMore) currentPage.value++;
      },
    );

    isLoading.value = false;
  }


  void updateTypeFilter(String value) {
    selectedTypeFilter.value = value;
    fetchOrders();
  }

  void updateStatusFilter(String value) {
    selectedStatusFilter.value = value;
    fetchOrders();
  }

  void toggleDateFilter() {
    isDateFilterActive.value = !isDateFilterActive.value;
    fetchOrders();
  }

  Future<void> pickDate(bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: isFromDate ? fromDate.value : toDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isFromDate) {
        fromDate.value = picked;
      } else {
        toDate.value = picked;
      }
      isDateFilterActive.value = true;
      fetchOrdersWithDateRange();
    }
  }

  Future<void> fetchSpecializations() async {
    final response = await crud.getData(AppLink.getSpecialization, AppLink().getHeaderToken());
    response.fold(
          (error) => Get.snackbar("خطأ", "فشل في تحميل الإختصاصات."),
          (data) {
        try {
          final List<SpecializationWrapper> specializationsWrapper = (data['specializations'] as List)
              .map((item) => SpecializationWrapper.fromJson(item))
              .toList();
          specializations.value = specializationsWrapper.map((e) => e.specialization).toList();
        } catch (_) {
          Get.snackbar("خطأ", "فشل في تحميل بيانات الإختصاصات.");
        }
      },
    );
  }

  Future<void> fetchClinicsWithSpecialPrice(int productId, int clinicId) async {
    try {
      showLoadingDialog();
      final response = await crud.getData(
        "${AppLink.getClinicsWithSpecialPrice}/$productId",
        AppLink().getHeaderToken(),
      );
      response.fold(
            (error) => specialPrices[productId] = Rxn<double>(0.0),
            (data) {
          if (data != null && data['clinics'] != null) {
            final clinics = (data['clinics'] as List)
                .map((json) => SpecialPriceClinicResponse.fromJson(json))
                .toList();
            final clinicSpecialPrice = clinics.firstWhereOrNull(
                  (clinic) => clinic.clinic.id == clinicId && clinic.clinic.hasSpecialPrice == true,
            );
            specialPrices[productId] = Rxn<double>(clinicSpecialPrice?.price ?? 0.0);
          } else {
            specialPrices[productId] = Rxn<double>(0.0);
          }
        },
      );
    } catch (_) {
      specialPrices[productId] = Rxn<double>(0.0);
    } finally {
      hideLoadingDialog();
    }
  }

  Future<void> createOrder() async {
    if (specializationSubscriberId.value == 0) {
      Get.snackbar("خطأ", "الرجاء اختيار تخصص.");
      return;
    }
    final body = {
      "subscriber_id": myServices.sharedPreferences.getInt(SharedPreferencesKeys.subscriberId),
      "doctor_id": doctorId.value,
      "status": status.value,
      "type": type.value,
      "invoiced": true,
      "paid": paidAmountController.text,
      "patient_name": patientNameController.text,
      "receive": receiveDateController.text,
      "delivery": deliveryDateController.text,
      "patient_id": patientIdController.text,
      "specialization": specializations.firstWhere((e) => e.id == specializationSubscriberId.value).name,
      "products": [
        {
          "product_id": productId.value,
          "tooth_color_id": toothColorId.value,
          "tooth_number": teethNumbers.toString(),
          "specialization_subscriber_id": specializationSubscriberId.value,
          "note": note.text
        },
      ]
    };
    final response = await crud.postData(AppLink.createOrder, body, AppLink().getHeaderToken());
    response.fold(
          (error) => Get.snackbar('خطأ', 'يرجى ملء جميع الحقول بشكل صحيح.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white),
          (data) => Get.snackbar('نجاح', 'تم إنشاء الطلب بنجاح!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white),
    );
  }
}
