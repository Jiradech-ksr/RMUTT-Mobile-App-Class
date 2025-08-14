import 'package:flutter/material.dart';

void main() {
  runApp(const App802());
}

class App802 extends StatelessWidget {
  const App802({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: HomePage());
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _Value = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('App802')),
    body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [btnMinus(), Text('$_Value'), btnPlus()],
      ),
    ),
  );
  Widget btnMinus() => OutlinedButton(
    onPressed: () {
      if (_Value > 0) {
        setState(() => _Value -= 1);
      }
    },
    style: OutlinedButton.styleFrom(
      side: BorderSide(
        color: Colors.black26,
        width: 1.2,
        style: BorderStyle.solid,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: const Text(' - ', style: TextStyle(fontSize: 30)),
  );
  Widget btnPlus() => OutlinedButton(
    onPressed: () {
      setState(() => _Value += 1);
    },
    style: OutlinedButton.styleFrom(
      side: BorderSide(
        color: Colors.black26,
        width: 1.2,
        style: BorderStyle.solid,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: const Text(' + ', style: TextStyle(fontSize: 30)),
  );
}
