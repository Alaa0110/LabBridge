import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../../core/service/link.dart';
import '../../../../../../model/category_model.dart';


class CategoryController extends GetxController {
  var categories = <Category>[].obs;

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(AppLink.getCategory),
        headers: AppLink().getHeaderToken(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        categories.value = (data['categories'] as List)
            .map((json) => Category.fromJson(json))
            .toList();
        debugPrint('Fetched categories: $categories');
      } else {
        debugPrint('Fetch failed with status: ${response.statusCode}, body: ${response.body}');
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      debugPrint('Error while fetching categories: $e');
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    }
  }

  Future<void> addCategory(String name) async {
    try {
      final response = await http.post(
        Uri.parse(AppLink.addCategory),
        headers: AppLink().getHeaderToken(),
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Category added successfully');
        fetchCategories();
      } else {
        throw Exception('Failed to add category');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add category: $e');
    }
  }
  Future<void> editCategory(String name,int id) async {
    try {
      final response = await http.post(
        Uri.parse(AppLink.editCategory),
        headers: AppLink().getHeaderToken(),
        body: jsonEncode({'name': name , 'id': id}),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Category edit successfully');
        fetchCategories();
      } else {
        throw Exception('Failed to edit category');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to edit category: $e');
    }
  }
  Future<void> deleteCategory(int id) async {
    try {

      final response = await http.get(
        Uri.parse('${AppLink.deleteCategory}/$id'),
        headers: AppLink().getHeaderToken(),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Category deleted successfully');
        await fetchCategories(); // Ensure state is updated after deletion
      } else {
        debugPrint('Delete failed with status: ${response.statusCode}, body: ${response.body}');
        debugPrint('Final URL: ${AppLink.deleteCategory}/$id');

        throw Exception('Failed to delete category. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error while deleting category: $e');
      debugPrint('Final URL: ${AppLink.deleteCategory}/$id');
      Get.snackbar('Error', 'Failed to delete category: $e');
    }
  }
}
