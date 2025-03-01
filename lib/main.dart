import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickshif/view/splash_screen/splash_screen.dart';

import 'controller/login_controller/login_controller.dart';
import 'controller/user_controller/user_controller.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(LoginController(),tag: 'login_controller');
  Get.put(UserController(),tag: 'user_controller');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}
