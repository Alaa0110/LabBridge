import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labbridge/binding/initial_bindings.dart';
import 'package:labbridge/core/const_data/app_colors.dart';
import 'core/service/media_query.dart';
import 'core/routes/routes.dart';
import 'core/service/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 852),
      minTextAdapt: true,
      splitScreenMode: true,
        builder: (_, child) { return GetMaterialApp(
          locale: const Locale('ar'),
        theme: ThemeData(scaffoldBackgroundColor: AppColors.backgroundColor,appBarTheme: const AppBarTheme(backgroundColor:AppColors.backgroundColor )),
        debugShowCheckedModeBanner: false,
        title: 'LabBridge',
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.initial,
        getPages: AppRoutes.routes,
        );
        },
    );
  }
}