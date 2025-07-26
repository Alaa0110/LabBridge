// Path: lib/screens/doctors/widgets/doctor_list_item.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../controller/doctors_controller.dart';
import 'confirm_delete_dialog.dart';

class DoctorListItem extends StatelessWidget {
  final dynamic doctor;
  final int index;
  final DoctorController controller;

  const DoctorListItem({
    super.key,
    required this.doctor,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(doctor.id),
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
          showConfirmDeleteDoctorDialog(context, controller, doctor.id),
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
                doctor.firstName[0],
                style: const TextStyle(fontFamily: AppFonts.regular),
              ),
            ),
            title: Text(
              "${doctor.firstName} ${doctor.lastName}",
              style: const TextStyle(
                fontFamily: AppFonts.regular,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text("ID: ${doctor.id}"),
          ),
        ),
      ),
    );
  }
}
