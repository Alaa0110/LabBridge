// lib/views/technicals_page.dart

/*class ShowTechnical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminController = Get.find<AdminController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الفنيين'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() {
          if (adminController.technicals.isEmpty) {
            return const Center(child: Text('.لايوجد فنيين لعرضهم , يرجى مشاركة رمز المعمل معهم لعرضهم لك'));
          }

          return ListView.builder(
            itemCount: adminController.technicals.length,
            itemBuilder: (context, index) {
              final technical = adminController.technicals[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(
                    technical.isAvailable ? Icons.check_circle : Icons.cancel,
                    color: technical.isAvailable ? Colors.green : Colors.red,
                    size: 40,
                  ),
                  title: Text('${technical.firstName} ${technical.lastName}'),
                  subtitle: Text(technical.email),
                  trailing: Text(
                    technical.isAvailable ? 'متاح' : 'غير متاح',
                    style: TextStyle(
                      color: technical.isAvailable ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}*/
