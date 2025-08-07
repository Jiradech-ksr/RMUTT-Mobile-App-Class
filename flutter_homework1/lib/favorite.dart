import 'package:flutter/material.dart';

void main() {
  runApp(const Favorite());
}

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        height: screenHeight,
        color: const Color.fromARGB(255, 247, 242, 220),
        child: Stack(
          children: [
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.code,
                        size: 80,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'เขียนโคดและสร้างเว็บไซต์',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 20),
                      Icon(
                        Icons.book_sharp,
                        size: 80,
                        color: Color.fromARGB(255, 66, 58, 34),
                      ),

                      SizedBox(height: 20),
                      Text(
                        'อ่านนิยาย',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
