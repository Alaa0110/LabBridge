import 'package:get/get.dart';
import 'package:labbridge/view/admin/controller/admin_controller.dart';
import '../core/class/crud.dart';
import '../core/service/network_connection.dart';



class InitialBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(Crud());
    Get.put(NetworkManager());
    Get.put(AdminController());
  }
}