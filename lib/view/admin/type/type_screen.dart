import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import 'controller/type_controller.dart';

class TypePage extends StatelessWidget {
  final TypeController controller = Get.put(TypeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إدارة الأنواع")),
      body: GetBuilder<TypeController>(builder: (_) {
        if (controller.statusRequest == StatusRequest.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("الأنواع المتاحة", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                children: controller.fixedTypes.map((typeInfo) {
                  String label = typeInfo['label']!;
                  String value = typeInfo['value']!;
                  bool isSelected = controller.selected.containsKey(value);
                  bool invoiced = controller.selected[value] ?? false;

                  return Card(
                    child: ListTile(
                      title: Text(label),
                      subtitle: Row(
                        children: [
                          Text("مفوتر؟"),
                          Switch(
                            value: invoiced,
                            onChanged: isSelected
                                ? null
                                : (val) {
                              controller.selected[value] = val;
                              controller.update();
                            },
                          ),
                        ],
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check, color: Colors.green)
                          : ElevatedButton(
                        onPressed: () {
                          controller.addType(value, controller.selected[value] ?? false);
                        },
                        child: Text("إضافة"),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("الأنواع المضافة", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: controller.types.length,
                itemBuilder: (context, index) {
                  final item = controller.types[index];
                  return ListTile(
                    title: Text(item.type),
                    subtitle: Text("مفوتر: ${item.invoiced == 1 ? 'نعم' : 'لا'}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteType(item.id),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
