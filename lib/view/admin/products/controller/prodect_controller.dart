import 'package:get/get.dart';
import '../../../../../../core/class/crud.dart';
import '../../../../../../core/class/status_request.dart';
import '../../../../../../core/service/link.dart';
import '../../../../../../model/product_model.dart';


class ProductController extends GetxController {
  final Crud crud = Crud();
  var productsByCategory = <int, List<Product>>{}.obs;
  RxList<Product> allProducts = <Product>[].obs; // Store all available products
  RxMap<int, double> specialPrices = <int, double>{}.obs; // Map product IDs to special prices
  RxInt currentClinicId = 0.obs;

  /// Fetch products by category using Crud
  Future<void> fetchProductsByCategory(int categoryId) async {
    final response = await crud.getData(
      '${AppLink.showProductsByCategory}/$categoryId',
      AppLink().getHeaderToken(),
    );

    response.fold(
          (failure) {
        if (failure == StatusRequest.offlineFailure) {
          Get.snackbar('Error', 'No internet connection');
        } else {
          Get.snackbar('Error', 'Failed to fetch products');
        }
      },
          (success) {
        productsByCategory[categoryId] = (success['products'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
      },
    );
  }

  /// Add a new product using Crud
  Future<void> addProduct(String name, int categoryId, double price) async {
    final data = {'name': name, 'category_id': categoryId, 'price': price};
    final response = await crud.postData(
      AppLink.addProducts,
      data,
      AppLink().getHeaderToken(),
    );


    response.fold(
          (failure) {
        if (failure == StatusRequest.offlineFailure) {
          Get.snackbar('Error', 'No internet connection');
        } else {
          Get.snackbar('Error', 'Failed to add product');
        }
      },
          (success) {
        Get.snackbar('Success', 'Product added successfully');
        fetchProductsByCategory(categoryId); // Refresh products in the category
      },
    );
  }

  /// Edit product name using Crud
  Future<void> editProductName(int productId, String newName) async {
    final data = {'id': productId, 'newName': newName};
    final response = await crud.postData(
      AppLink.editProducts,
      data,
      AppLink().getHeaderToken(),
    );

    response.fold(
          (failure) {
        if (failure == StatusRequest.offlineFailure) {
          Get.snackbar('Error', 'No internet connection');
        } else {
          Get.snackbar('Error', 'Failed to update product name');
        }
      },
          (success) {
        Get.snackbar('Success', 'Product name updated successfully');
      },
    );
  }

  /// Delete a product using Crud
  Future<void> deleteProduct(int productId, int categoryId) async {
    final response = await crud.getData(
      '${AppLink.deleteProducts}/$productId',
      AppLink().getHeaderToken(),
    );

    response.fold(
          (failure) {
        if (failure == StatusRequest.offlineFailure) {
          Get.snackbar('Error', 'No internet connection');
        } else {
          Get.snackbar('Error', 'Failed to delete product');
        }
      },
          (success) {
        Get.snackbar('Success', 'Product deleted successfully');
        fetchProductsByCategory(categoryId); // Refresh products in the category
      },
    );
  }

  /// Edit product price using Crud
  Future<void> editPrice(int productId, double price) async {
    final data = {'id': productId, 'price': price};
    final response = await crud.postData(
      AppLink.editPrice,
      data,
      AppLink().getHeaderToken(),
    );

    response.fold(
          (failure) {
        if (failure == StatusRequest.offlineFailure) {
          Get.snackbar('Error', 'No internet connection');
        } else {
          Get.snackbar('Error', 'Failed to update price');
        }
      },
          (success) {
        Get.snackbar('Success', 'Price updated successfully');
      },
    );
  }
}
