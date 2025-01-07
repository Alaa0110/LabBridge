import 'package:get/get.dart';
import '../core/class/crud.dart';
import '../core/service/network_connection.dart';
import '../view/admin/clinics/controller/clinics_controller.dart';



class InitialBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(Crud());
    Get.put(NetworkManager());
    Get.put(ClinicController());
  }
}