import 'package:flutter/material.dart';

class OddNumbersPage extends StatelessWidget {
  const OddNumbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Odd Numbers 1-1000')),
      body:
          // Use a ListView.builder for efficiency. This only builds the
          // list items that are currently visible on the screen.
          ListView.builder(
            // There are 500 odd numbers between 1 and 1000
            // (1, 3, 5, ..., 999)
            itemCount: 500,
            itemBuilder: (BuildContext context, int index) {
              // Calculate the odd number based on the index
              // index 0 -> (0 * 2) + 1 = 1
              // index 1 -> (1 * 2) + 1 = 3
              // index 2 -> (2 * 2) + 1 = 5
              // ...
              // index 499 -> (499 * 2) + 1 = 999
              final oddNumber = (index * 2) + 1;

              return ListTile(title: Text('Number: $oddNumber'));
            },
          ),
    );
  }
}
