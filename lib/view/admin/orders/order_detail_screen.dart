import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/service/link.dart';
import '../../../model/order_model.dart';
import 'package:http/http.dart' as http;

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تفاصيل الطلب #${order.id}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("المريض: ${order.patientName}", style: const TextStyle(fontSize: 18)),
            Text("التخصص: ${order.specialization}"),
            Text("الحالة: ${order.status}"),
            Text("الاستلام: ${order.receiveDate}"),
            if (order.deliveryDate != null) Text("التسليم: ${order.deliveryDate}"),
            const SizedBox(height: 16),
            const Text("المنتجات:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...order.products.map((p) => ListTile(
              title: Text(p.productName),
              subtitle: Text("رقم السن: ${p.toothNumber ?? '—'}"),
              trailing: Text("${p.price}"),

            )),
          ],
        ),
      ),
    );
  }
}

