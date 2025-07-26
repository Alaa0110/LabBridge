import 'package:get/get.dart';
import '../../../../core/class/crud.dart';
import '../../../../core/class/status_request.dart';
import '../../../../core/service/link.dart';
import '../../../../model/type_model.dart';


class TypeController extends GetxController {
  Crud crud = Crud();
  StatusRequest statusRequest = StatusRequest.none;

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  List<TypeModel> types = [];

  final fixedTypes = [
    {'label': 'جديد', 'value': 'new'},
    {'label': 'آجلة', 'value': 'futures'},
    {'label': 'تجربة', 'value': 'test'},
    {'label': 'إعادة', 'value': 'returned'},
  ];

  Map<String, bool> selected = {}; // selected[type] = invoiced

  @override
  void onInit() {
    getTypes();
    super.onInit();
  }

  void getTypes() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await crud.getData(AppLink.getType, headers);
    response.fold((fail) {
      statusRequest = fail;
    }, (data) {
      types = List<TypeModel>.from(data['types'].map((e) => TypeModel.fromJson(e)));
      for (var item in types) {
        selected[item.type] = item.invoiced == 1;
      }
      statusRequest = StatusRequest.success;
    });
    update();
  }

  Future<void> addType(String type, bool invoiced) async {
    if (selected.containsKey(type)) {
      Get.snackbar("موجود", "النوع مضاف مسبقًا");
      return;
    }
    var response = await crud.postData(AppLink.addType, {
      'type': type,
      'invoiced': invoiced,
    }, headers);
    response.fold((fail) {
      Get.snackbar("خطأ", "فشل في الإضافة");
    }, (data) {
      getTypes();
      Get.snackbar("تم", "تمت إضافة النوع");
    });
  }

  Future<void> deleteType(int id) async {
    var response = await crud.deleteData("${AppLink.updateType}/$id", headers);
    response.fold((fail) {
      Get.snackbar("خطأ", "فشل في الحذف");
    }, (data) {
      selected.removeWhere((key, _) => types.firstWhere((e) => e.id == id).type == key);
      getTypes();
      Get.snackbar("تم", "تم حذف النوع");
    });
  }
}
