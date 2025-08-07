import 'package:flutter/material.dart';

void main() {
  runApp(const Design());
}

class Design extends StatelessWidget {
  const Design({super.key});

  @override
  Widget build(BuildContext context) {
    double itemWidth = 133;
    double itemHeight = 288;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            buildImage('assets/images/0.png', itemWidth, itemHeight),
            buildImage('assets/images/1.png', itemWidth, itemHeight),
            buildImage('assets/images/2.png', itemWidth, itemHeight),
            buildImage('assets/images/3.png', itemWidth, itemHeight),
            buildImage('assets/images/4.png', itemWidth, itemHeight),
            buildImage('assets/images/5.png', itemWidth, itemHeight),
            buildImage('assets/images/10.png', itemWidth, itemHeight),
            buildImage('assets/images/11.png', itemWidth, itemHeight),
            buildImage('assets/images/12.png', itemWidth, itemHeight),
            buildImage('assets/images/13.png', itemWidth, itemHeight),
            buildImage('assets/images/14.png', itemWidth, itemHeight),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String path, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        path,
        fit: BoxFit.cover,
        cacheWidth: width.toInt(),
        cacheHeight: height.toInt(),
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.error, color: Colors.red));
        },
      ),
    );
  }
}
