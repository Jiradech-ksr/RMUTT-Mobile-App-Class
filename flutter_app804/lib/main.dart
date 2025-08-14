import 'package:flutter/material.dart';

void main() {
  Widget app = MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('สวัสดี AppBar'), // "Hello AppBar" in Thai
        centerTitle: true,
      ),
      body: const Center(
        child: Text('ทดสอบ'), // "Test" in Thai
      ),
      floatingActionButton: FloatingActionButton(
        // Optional alternative: Text button instead of icon
        // child: const Text('ปุ่ม A', style: TextStyle(fontSize: 20)),
        child: const Icon(
          Icons.settings,
          size: 30,
          color: Colors.red,
        ),
        onPressed: () {
          print('ได้กดปุ่มเรียบร้อย'); // "Button successfully pressed"
        },
      ),
    ),
  );

  runApp(app);
}
