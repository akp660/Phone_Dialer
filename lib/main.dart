import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/theme/theme_controller.dart';

import 'controllers/call_controller.dart';
import 'controllers/contact_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize controllers
  Get.put(ThemeController());
  final ThemeController themeController = Get.put(ThemeController());
  final ContactsController contactsController = Get.put(ContactsController());
  final CallController callController = Get.put(CallController());

  // Request permissions
  await Permission.contacts.request();
  await Permission.phone.request();
  // await Permission.callLog.request();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Dialer',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}