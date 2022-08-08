import 'package:flutter/material.dart';
import 'package:news_app/screens/splash_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          primaryColor: Colors.black),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
