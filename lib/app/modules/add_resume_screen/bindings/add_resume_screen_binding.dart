import 'package:get/get.dart';

import '../controllers/add_resume_screen_controller.dart';

class AddResumeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddResumeScreenController>(
      () => AddResumeScreenController(),
    );
  }
}
