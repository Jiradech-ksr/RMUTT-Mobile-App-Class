import 'package:flutter/material.dart';
import 'package:flutter_homework1/me.dart';
import 'package:flutter_homework1/education.dart';
import 'package:flutter_homework1/skill.dart';
import 'package:flutter_homework1/desing.dart';
import 'package:flutter_homework1/favorite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(title: const Text('MyApp')),
        body: const TabBarView(
          children: [Me(), Education(), Skill(), Design(), Favorite()],
        ),
        bottomNavigationBar: const Material(
          child: TabBar(
            isScrollable: false,
            labelStyle: TextStyle(fontSize: 14),
            labelPadding: EdgeInsets.only(bottom: 4),
            tabs: [
              Tab(icon: Icon(Icons.home, size: 32), text: 'Main'),
              Tab(icon: Icon(Icons.school, size: 32), text: 'Education'),
              Tab(icon: Icon(Icons.engineering, size: 32), text: 'Skills'),
              Tab(icon: Icon(Icons.folder, size: 32), text: 'Work'),
              Tab(icon: Icon(Icons.favorite, size: 32), text: 'Interest'),
            ],
          ),
        ),
      ),
    );
  }
}
