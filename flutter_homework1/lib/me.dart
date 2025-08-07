import 'package:flutter/material.dart';

void main() {
  runApp(const Me());
}

class Me extends StatelessWidget {
  const Me({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;

        return SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 247, 242, 220),
            height: screenHeight,
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Center(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'ชื่อ-นามสกุล นาย จิระเดช คุ้มศิริ',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'ชื่อเล่น ต้น',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'เกิดเมื่อ 23 มิถุนายน 2545',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 6),
                            Text('อายุ 23', style: TextStyle(fontSize: 18)),
                            SizedBox(height: 6),
                            Text('สัญชาติไทย', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
