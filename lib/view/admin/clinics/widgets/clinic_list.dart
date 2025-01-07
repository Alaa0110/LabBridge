// Path: lib/screens/clinics/widgets/clinic_list_item.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/const_data/app_fonts.dart';
import '../../doctors/doctors_screen.dart';
import '../controller/clinics_controller.dart';
import 'confirm_delete_dialog.dart';
import 'edit_clinic_dialog.dart';

class ClinicListItem extends StatelessWidget {
  final dynamic clinic;
  final int index;
  final ClinicController controller;

  const ClinicListItem({
    Key? key,
    required this.clinic,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(clinic.id),
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
          showConfirmDeleteDialog(context, controller, clinic.id),
      child: BounceInDown(
        duration: Duration(milliseconds: 300 + index * 100),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: ListTile(
            leading:Image.asset(
              'assets/images/clinic.png',
              height: 40,
              width: 40,
            ),
            title: Text(
              clinic.name,
              style: const TextStyle(
                fontFamily: AppFonts.regular,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text("الرقم الضريبي: ${clinic.taxNumber ?? 'لايوجد'}"),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {
                controller.prepareEditClinic(clinic);
                showEditClinicDialog(context, controller,
                    TextEditingController()..text = clinic.name,
                    TextEditingController()..text = clinic.taxNumber ?? '');
              },
            ),
            onTap: () {
              Get.to(() => DoctorPage(clinicId: clinic.id));
            },
          ),
        ),
      ),
    );
  }
}
