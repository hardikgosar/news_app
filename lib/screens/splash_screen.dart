import 'dart:async';

import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: size.width * 0.6,
        width: size.width * 0.6,
        child: Image.asset(
          'assets/images/news.png',
          fit: BoxFit.contain,
        ),
      )),
    );
  }
}
