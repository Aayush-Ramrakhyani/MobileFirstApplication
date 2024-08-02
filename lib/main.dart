import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilefist_application/SplashScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
