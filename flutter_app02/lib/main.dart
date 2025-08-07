import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(App02());

class App02 extends StatelessWidget {
  const App02({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var rnd = Random();
  num _r = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('data')),
    body: Center(
      child: Column(
        children: [
          SizedBox(height: 15),
          Text(_r.toString()),
          SizedBox(height: 20),
          TextButton(
            child: Text('rand num'),
            onPressed: () {
              setState(() {
                _r = rnd.nextInt(100);
              });
            },
          ),
        ],
      ),
    ),
  );
}
