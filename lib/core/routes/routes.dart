import 'package:get/get.dart';
import 'package:labbridge/view/home/home_screen.dart';
import 'package:labbridge/view/main/main_screen.dart';
import 'package:labbridge/view/splash/splash_screen.dart';
import 'package:labbridge/view/technical/techincal_screen.dart';
import '../../view/admin/admin_screen.dart';
import '../../view/auth/admin/admin_register_screen.dart';
import '../../view/auth/login/login_screen.dart';


class AppRoutes {

  static const initial = '/';
  static const main = '/main';
  static const registerAdmin = '/register_admin';
  static const login = '/login';
  static const success = '/success';
  static const admin = '/admin';
  static const registerSelection = '/register_selection';
  static const doctor = '/doctor';
  static const technicalRegister = '/technical_register';
  static const technical = '/technical';
  static const showTechnical = '/showtechnical';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () =>  SplashScreen()),
    GetPage(name: main, page: () =>  MainScreen()),
    GetPage(name: registerAdmin, page: () => AdminRegisterPage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: success, page: () => const SuccessPage()),
    GetPage(name: admin, page: () =>  const AdminPage()),
  //  GetPage(name: registerSelection, page: () => RegisterSelectionPage()),
   // GetPage(name: doctor, page: () => const DoctorPage()),
   // GetPage(name: technicalRegister, page: () => TechnicalRegisterScreen()),
    GetPage(name: technical, page: () => const TechnicalPage()),
   // GetPage(name: showTechnical, page: () => ShowTechnical()),
  ];
}
