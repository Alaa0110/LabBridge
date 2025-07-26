import 'package:get/get.dart';
import '../../../../core/class/crud.dart';
import '../../../../core/service/link.dart';
import '../../../../model/technical_model.dart';


class TechnicalController extends GetxController {
  final Crud crud = Crud();
  var technicals = <Technical>[].obs;

  /// Fetch all technicals from the API
  Future<void> fetchTechnicals() async {
    final response = await crud.getData(
        AppLink.getTechnicals, AppLink().getHeaderToken());

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch technicals');
        print('Error fetching technicals: $failure'); // Log the error
      },
          (success) {
        print(
            'Technicals fetched successfully: $success'); // Log the raw response
        technicals.value = (success as List)
            .map((json) => Technical.fromJson(json))
            .toList();
      },
    );
  }


  /// Toggle technical availability
  Future<void> toggleAvailability(int technicalId, bool isAvailable) async {
    final body = {'is_available': isAvailable ? 1 : 0};
    final response = await crud.patchData(
      '${AppLink.technicalsAvailability}/$technicalId',
      body,
      AppLink().getHeaderToken(),
    );

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to update availability');
      },
          (success) {
        final message = success['message'];
        final updatedAvailability = success['is_available'];
        Get.snackbar('Success', message);

        // Update the technical's availability locally
        final technicalIndex = technicals.indexWhere((tech) =>
        tech.id == technicalId);
        if (technicalIndex != -1) {
          technicals[technicalIndex] = Technical(
            id: technicals[technicalIndex].id,
            email: technicals[technicalIndex].email,
            isAvailable: updatedAvailability,
            firstName: technicals[technicalIndex].firstName,
            lastName: technicals[technicalIndex].lastName,
            specializations: technicals[technicalIndex].specializations,
          );
        }
      },
    );
  }
}
