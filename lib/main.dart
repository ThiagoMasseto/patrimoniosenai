import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'controllers/patrimonio_controller.dart';
import 'views/patrimonio_list_view.dart';
import 'views/patrimonio_detail_view.dart';
import 'views/patrimonio_form_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Patrimônios SENAI',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE30613), // Vermelho SENAI
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE30613),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFE30613),
          foregroundColor: Colors.white,
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(PatrimonioController());
      }),
      getPages: [
        GetPage(
          name: '/',
          page: () => const PatrimonioListView(),
        ),
        GetPage(
          name: '/detalhes',
          page: () => const PatrimonioDetailView(),
        ),
        GetPage(
          name: '/formulario',
          page: () => PatrimonioFormView(),
        ),
      ],
    );
  }
}
