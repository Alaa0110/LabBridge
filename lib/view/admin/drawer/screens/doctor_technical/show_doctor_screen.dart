// lib/views/doctors_page.dart



/*class ShowDoctors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminController = Get.find<AdminController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الأطباء'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() {
          if (adminController.doctors.isEmpty) {
            return const Center(child: Text('.لايوجد أطباء لعرضهم , يرجى مشاركة رمز المعمل معهم لعرضهم لك'));
          }

          return ListView.builder(
            itemCount: adminController.doctors.length,
            itemBuilder: (context, index) {
              final doctor = adminController.doctors[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue, size: 40),
                  title: Text('${doctor.firstName} ${doctor.lastName}'),
                  subtitle: Text('${"عيادة: "} ${doctor.clinicName}'),
                  isThreeLine: true,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}*/
