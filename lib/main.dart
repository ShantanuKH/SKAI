import 'package:flutter/material.dart';
import 'package:voice_assistance_app/home_page.dart';
import 'package:voice_assistance_app/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SKAI | My Assistant",
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: AppBarTheme(backgroundColor: Pallete.whiteColor)
      ),
      home:HomePage(),
    );
  }
}

