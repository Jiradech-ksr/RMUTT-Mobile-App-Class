import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData.dark(),
      initialRoute: 'home', // Home page is now the first page
      routes: {
        'register': (context) => register(),
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
      },
    );
  }
}