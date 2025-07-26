import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/order_controller.dart';
import 'order_detail_screen.dart';



class OrdersListContent extends StatelessWidget {
  final controller = Get.put(CreateOrderController());

  OrdersListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.orders.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("نوع الفاتورة: "),
                      DropdownButton<String>(
                        value: controller.selectedTypeFilter.value,
                        items: ["all", "returned", "new", "futures", "test"]
                            .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateTypeFilter(value);
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("الحالة: "),
                      DropdownButton<String>(
                        value: controller.selectedStatusFilter.value,
                        items: ["all", "pending", "completed", "cancelled"]
                            .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateStatusFilter(value);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.orders.length + (controller.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= controller.orders.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final order = controller.orders[index];
                return Card(
                  child: ListTile(
                    title: Text("المريض: ${order.patientName}"),
                    subtitle: Text("نوع الفاتورة: ${order.status} | التخصص: ${order.specialization}"),
                    trailing: Text("المبلغ: ${order.paid}"),
                    onTap: () => Get.to(() => OrderDetailsPage(order: order)),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

