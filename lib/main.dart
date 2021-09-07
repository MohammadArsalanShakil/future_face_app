import 'package:flutter/material.dart';
import 'package:future_face_app/screens/import.dart';
import 'package:future_face_app/screens/result.dart';
import 'package:future_face_app/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/import': (context) => ImportScreen(),
        '/result': (context) => ResultScreen(),
      },
    );
  }
}
