import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:labbridge/core/const_data/app_image.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../core/const_data/app_colors.dart';
import '../../../../../core/const_data/app_fonts.dart';
import '../../../core/const_data/app_texts.dart';
import '../../../core/const_data/styles.dart';
import '../../../widgets/custom_app_bar.dart';
import 'controller/category_controller.dart';
import 'products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final categoryController = Get.put(CategoryController());

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    categoryController.fetchCategories();

    return Scaffold(
      appBar: const CustomAppBar(
        title:"المجموعات",

      ),
      body: Obx(() {
        if (categoryController.categories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppImage.empty, height: 200.h),
                 SizedBox(height: 15.h),
                 Text(
                     AppTexts.noCategoryAdded,
                  style: Styles.style18
                ),
                 SizedBox(height: 5.h,),
                 Text(
                     AppTexts.exampleOfAddedCategory,
                  style: Styles.style16
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            final category = categoryController.categories[index];

            return Dismissible(
              key: ValueKey(category.id),
              direction: DismissDirection.startToEnd,
              background: Container(
                width: 1,
                alignment: Alignment.centerRight,
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r),color: Colors.red),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              confirmDismiss: (direction) => _showConfirmDeleteDialog(context, category.id),
              child: BounceInDown(
                duration: Duration(milliseconds: 300 + index * 100),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/images/product_tooth.svg',
                      height: 40,
                      width: 40,
                      color: Colors.blue,
                    ),
                    title: Text(
                      category.name,
                      style: const TextStyle(
                        fontFamily: AppFonts.regular,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      onPressed: () {
                        _showEditCategoryDialog(context, category.id, category.name);
                      },
                    ),
                    onTap: () {
                      Get.to(() => ProductsScreen(
                        categoryId: category.id,
                        categoryName: category.name,
                      ));
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColors.primaryLightColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<bool> _showConfirmDeleteDialog(BuildContext context, int categoryId) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'تأكيد الحذف',
            style: TextStyle(fontFamily: AppFonts.regular),
          ),
          content: const Text(
            'هل أنت متأكد أنك تريد حذف هذه المجموعة؟',
            style: TextStyle(fontFamily: AppFonts.regular),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel deletion
              },
              child: const Text(
                'إلغاء',
                style: TextStyle(color: AppColors.primaryColor, fontFamily: AppFonts.regular),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.deleteCategory(categoryId); // Confirm deletion
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'حذف',
                style: TextStyle(color: Colors.red, fontFamily: AppFonts.regular),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _showAddCategoryDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'اسم المجموعة',
                      hintStyle: Styles.style16,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final categoryName = nameController.text.trim();
                      if (categoryName.isNotEmpty) {
                        categoryController.addCategory(categoryName);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'اضف مجموعة',
                      style: TextStyle(
                        fontFamily: AppFonts.regular,
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditCategoryDialog(BuildContext context, int id, String currentName) {
    final TextEditingController nameController = TextEditingController(text: currentName);

    showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'تعديل اسم المجموعة',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final newName = nameController.text.trim();
                      if (newName.isNotEmpty) {
                        categoryController.editCategory(newName, id);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'تعديل المجموعة',
                      style: TextStyle(
                        fontFamily: AppFonts.regular,
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
