import 'package:get/get.dart';

import '../modules/add_resume_screen/bindings/add_resume_screen_binding.dart';
import '../modules/add_resume_screen/views/add_resume_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_RESUME_SCREEN,
      page: () => const AddResumeScreenView(),
      binding: AddResumeScreenBinding(),
    ),
  ];
}
