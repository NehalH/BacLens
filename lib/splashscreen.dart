import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'main.dart';


// ignore: camel_case_types
class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

// ignore: camel_case_types
class _Splash_screenState extends State<Splash_screen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:Image.asset(
        'assets/images/1024.png',
      ),
      backgroundColor: Colors.white,
      nextScreen: const ImageUploads(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 250,
      duration: 2000,
    );
  }
}