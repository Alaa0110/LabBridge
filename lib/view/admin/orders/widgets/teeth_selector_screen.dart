import 'package:flutter/material.dart';
import 'package:labbridge/core/const_data/app_colors.dart';
import 'package:teeth_selector/teeth_selector.dart';
import 'package:get/get.dart';

import '../controller/order_controller.dart';



class teethSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TeethSelector(
          onChange: (selected) => Get.find<CreateOrderController>().teethNumbers.value = selected,
          multiSelect: true,
          notation: (isoString) => "Tooth ISO: $isoString",
          selectedColor: Colors.red,
          showPrimary: true,

        ),
      ),
    );
  }
}
