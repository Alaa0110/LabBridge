// models/order_model.dart
class Order {
  final int id;
  final String patientName;
  final int doctorId;
  final String? doctorName;
  final String receiveDate;
  final String? deliveryDate;
  final String status;
  final String specialization;
  final double paid;
  final double cost;
  final List<Product> products;

  Order({
    required this.id,
    required this.patientName,
    required this.receiveDate,
    this.deliveryDate,
    required this.status,
    required this.doctorId,
    this.doctorName,
    required this.specialization,
    required this.paid,
    required this.cost,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List;
    List<Product> productsList =
    productsJson.map((e) => Product.fromJson(e)).toList();

    return Order(
      id: json['id'],
      patientName: json['patient_name'],
      receiveDate: json['receive'],
      deliveryDate: json['delivery'],
      doctorId: json['doctor_id'],
      doctorName: json['doctor_name'], // optional if backend includes it
      status: json['status'],
      specialization: json['specialization'],
      paid: (json['paid'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      products: productsList,
    );
  }
}

class Product {
  final String? toothNumber;
  final String productName;
  final double price;

  Product({
    this.toothNumber,
    required this.productName,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      toothNumber: json['tooth_number'],
      productName: json['product']['name'],
      price: (json['product']['price'] as num).toDouble(),
    );
  }
}
