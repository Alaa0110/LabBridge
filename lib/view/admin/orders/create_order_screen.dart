// File: lib/view/admin/orders/create_order_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labbridge/view/admin/orders/teethcolor_screen.dart';
import 'package:labbridge/view/admin/orders/widgets/teeth_selector_screen.dart';
import 'categoryprodect_screen.dart';
import 'clinicsdoctor_screen.dart';
import 'controller/order_controller.dart';

class CreateOrderPage extends StatelessWidget {
  final CreateOrderController controller = Get.put(CreateOrderController());
  final _formKey = GlobalKey<FormState>();

  CreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء طلب جديد", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.indigo.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionTitle("المعلومات الأساسية"),
                _buildCard(
                  child: Column(
                    children: [
                      _buildDropdown(),
                      const SizedBox(height: 12),
                      _buildSelectionTile("اختر الطبيب", controller.doctorId, () async {
                        final result = await Get.to(() => ClinicDoctorPage());
                        if (result != null) {
                          controller.doctorId.value = result["doctorId"];
                          controller.clinicId.value = result["clinicId"];
                        }
                      }),
                      _buildSelectionTile("اختر المنتج", controller.productId, () async {
                        final productId = await Get.to(() => CategoryProductPage());
                        if (productId != null) {
                          controller.productId.value = productId;
                          if (controller.clinicId.value != 0) {
                            controller.fetchClinicsWithSpecialPrice(productId, controller.clinicId.value);
                          }
                        }
                      }),
                    ],
                  ),
                ),

                _buildSectionTitle("تفاصيل الطلب"),
                _buildCard(
                  child: Column(
                    children: [
                      _buildSelectionTile("اختر الحالة", controller.status, () async {
                        final selected = await _showOptionsDialog("اختر الحالة", ["pending", "completed", "cancelled"], ["حالية", "منتهية", "ملغية"]);
                        if (selected != null) controller.status.value = selected;
                      }),
                      _buildSelectionTile("اختر النوع", controller.type, () async {
                        final selected = await _showOptionsDialog("اختر النوع", ["new", "returned", "test", "futures"], ["جديدة", "إعادة", "تجربة", "آجلة"]);
                        if (selected != null) controller.type.value = selected;
                      }),
                      _buildSelectionTile("اختر لون الأسنان", controller.toothColorId, () async {
                        final id = await Get.to(() => TeethColorsPage());
                        if (id != null) controller.toothColorId.value = id;
                      }),
                      _buildSelectionTile<RxList<String>>("اختر الأسنان", controller.teethNumbers, () async {
                        final teeth = await Get.to(() => teethSelector());
                        if (teeth != null) controller.teethNumbers.value = teeth;
                      }),
                    ],
                  ),
                ),

                _buildSectionTitle("بيانات المريض"),
                _buildCard(
                  child: Column(
                    children: [
                      _buildTextField(controller.patientNameController, "اسم المريض", Icons.person),
                      _buildTextField(controller.paidAmountController, "المبلغ المدفوع", Icons.attach_money, TextInputType.number),
                      _buildTextField(controller.patientIdController, "رقم المريض", Icons.perm_identity, TextInputType.number),
                      _buildTextField(controller.note, "ملاحظات", Icons.note),
                    ],
                  ),
                ),

                _buildSectionTitle("التواريخ"),
                _buildCard(
                  child: Column(
                    children: [
                      _buildDatePicker("تاريخ الاستلام", controller.receiveDateController, today),
                      _buildDatePicker("تاريخ التسليم", controller.deliveryDateController, today),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
  );

  Widget _buildDropdown() => Obx(() => DropdownButtonFormField<int>(
    value: controller.specializationSubscriberId.value == 0 ? null : controller.specializationSubscriberId.value,
    decoration: _inputDecoration("اختر التخصص"),
    items: controller.specializations
        .map((s) => DropdownMenuItem<int>(value: s.id, child: Text(s.name)))
        .toList(),
    onChanged: (value) {
      if (value != null) controller.specializationSubscriberId.value = value;
    },
  ));

  Future<String?> _showOptionsDialog(String title, List<String> values, List<String> labels) async {
    return Get.defaultDialog<String>(
      title: title,
      content: Column(
        children: List.generate(values.length, (i) => ListTile(
          title: Text(labels[i]),
          onTap: () => Get.back(result: values[i]),
        )),
      ),
    );
  }

  Widget _buildSelectionTile<T>(String title, T value, VoidCallback onTap) {
    return Obx(() {
      String text;
      if (value is RxList && value.isEmpty) {
        text = "لم يتم التحديد";
      } else if (value is RxInt && value.value == 0) {
        text = "لم يتم التحديد";
      } else {
        text = value.toString();
      }
      return ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.white,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(text, style: TextStyle(color: Colors.grey[600])),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20),
        onTap: onTap,
      );
    });
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType type = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.indigo),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, TextEditingController controller, DateTime today) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: _inputDecoration(label),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: Get.context!,
            initialDate: today,
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (picked != null) {
            controller.text = DateFormat('y/M/d').format(picked);
          }
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) controller.createOrder();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text("إنشاء الطلب", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.indigo),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
