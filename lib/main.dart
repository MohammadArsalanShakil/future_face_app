import 'package:flutter/material.dart';
import 'package:future_face_app/screens/import.dart';
import 'package:future_face_app/screens/result.dart';
import 'package:future_face_app/screens/splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Future Face',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
