import 'package:flutter/material.dart';

void main() => runApp(const App801());

class App801 extends StatelessWidget {
  const App801({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('App801')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textButton(),
            const SizedBox(height: 30),
            elevatedButton(),
            const SizedBox(height: 30),
            outlinedButton(),
          ],
        ),
      ),
    ),
  );

  Widget textButton() => TextButton(
    onPressed: null, // Disabled button
    child: const Text(
      'data',
      style: TextStyle(
        color: Colors.indigo,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Tahoma',
      ),
    ),
  );

  Widget elevatedButton() => ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
    ),
    child: const Text(
      'elevated button',
      style: TextStyle(
        color: Colors.indigo,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  Widget outlinedButton() => OutlinedButton(
    onPressed: () {},
    child: const Text('outlined button', style: TextStyle(fontSize: 20)),
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        color: Colors.black26,
        width: 1.2,
        style: BorderStyle.solid,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      )
    ),
  );
}
