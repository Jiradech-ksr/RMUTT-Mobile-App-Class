import 'package:flutter/material.dart';

void main() => runApp(App03());

class App03 extends StatelessWidget {
  const App03({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(home: HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  num a = 15, b = 5;
  String _txt = '';

  void btn_pressed({String op = ''}) {
    setState(() {
      num r = 0;
      if (op == '+') {
        r = a + b;
      } else if (op == '-') {
        r = a - b;
      }
      _txt = '15 $op 5 = $r';
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('test app03')),
    body: Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(_txt, textScaleFactor: 1.2),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => btn_pressed(op: '+'),
            child: Text('$a+$b', textScaleFactor: 1.2),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => btn_pressed(op: '-'),
            child: Text('$a-$b', textScaleFactor: 1.2),
          ),
        ],
      ),
    ),
  );
}
