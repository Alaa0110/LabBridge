import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/show_technical_controller.dart';

class TechnicalsPage extends StatelessWidget {
  final technicalController = Get.put(TechnicalController());

  TechnicalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    technicalController.fetchTechnicals();

    return Scaffold(
      appBar: AppBar(
        title: const Text('الفنيين'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('ملاحظة'),
                    content: const Text(
                      'في حال وضع الفني بحالة غير نشط لن تأتي الحالات الجديدة إليه وستصل الحالات الجديدة للفني الآخر الذي بنفس الاختصاص .',
                      textAlign: TextAlign.justify,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('حسناً'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (technicalController.technicals.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: technicalController.technicals.length,
          itemBuilder: (context, index) {
            final technical = technicalController.technicals[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Text(
                            technical.firstName[0].toUpperCase(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${technical.firstName} ${technical.lastName}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'المختص به:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      children: technical.specializations
                          .map((spec) => Chip(
                        label: Text(
                          spec['name'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        backgroundColor: Colors.blue[100],
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'في حال التغيب عن الدوام او لأعطاءه إجازة:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Obx(() {
                          return Row(
                            children: [
                              Switch(
                                value: technical.isAvailable,
                                onChanged: (value) {
                                  technicalController.toggleAvailability(
                                    technical.id,
                                    value,
                                  );
                                },
                              ),
                              if (technicalController.technicals[index]
                                  .isAvailable)
                                const Text(
                                  "نشط",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.green),
                                )
                              else
                                const Text(
                                  "غير نشط",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red),
                                )
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
