import 'package:flutter/material.dart';

void main() => runApp(const App01());

class App01 extends StatelessWidget {
  const App01({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('appbar secton')),
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Top'),
            SizedBox(height: 50),
            Text('Middle'),
            SizedBox(height: 100),
            Text('bottom'),
            Center(
              child: Row(
                children: [
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text('1-1'),
                      SizedBox(height: 20),
                      Text('1-2'),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text('2-1'),
                      SizedBox(height: 20),
                      Text('2-2'),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text('3-1'),
                      SizedBox(height: 20),
                      Text('3-2'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
