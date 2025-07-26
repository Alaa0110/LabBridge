// Path: lib/screens/specializations/widgets/specialization_list_item.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../controller/specializations_controller.dart';
import '../../../../model/specialization_model.dart'; // Import the model
import 'confirm_delete_specialization_dialog.dart';

class SpecializationListItem extends StatelessWidget {
  final Specialization specialization; // Updated type
  final int index;
  final SpecializationController controller;

  const SpecializationListItem({
    super.key,
    required this.specialization,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(specialization.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) =>
          showConfirmDeleteSpecializationDialog(context, controller, specialization.id),
      child: BounceInDown(
        duration: Duration(milliseconds: 300 + index * 100),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                specialization.name[0], // Access nested name
                style: const TextStyle(fontFamily: AppFonts.regular),
              ),
            ),
            title: Text(
              specialization.name, // Access nested name
              style: const TextStyle(
                fontFamily: AppFonts.regular,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
