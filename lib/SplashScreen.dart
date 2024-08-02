import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilefist_application/HomeScreen.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(HomePage());
    });

    return Scaffold(
      body: Center(
        child: Text(
          'News App',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
