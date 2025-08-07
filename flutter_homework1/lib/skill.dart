import 'package:flutter/material.dart';

void main() {
  runApp(const Skill());
}

class Skill extends StatelessWidget {
  const Skill({super.key});

  final List<Map<String, dynamic>> skills = const [
    {'name': 'PHP', 'level': 'Beginner', 'icon': Icons.code},
    {'name': 'HTML', 'level': 'Beginner', 'icon': Icons.web},
    {'name': 'SQL', 'level': 'Beginner', 'icon': Icons.storage},
    {'name': 'Dart', 'level': 'Beginner', 'icon': Icons.flutter_dash},
    {'name': 'CSS', 'level': 'Beginner', 'icon': Icons.style},
    {'name': 'Python', 'level': 'Beginner', 'icon': Icons.code_off},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 247, 242, 220),
        child: Column(
          children: skills.map((skill) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      title: Text(
                        skill['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(skill['level']),
                      leading: Icon(
                        skill['icon'],
                        size: 30,
                        color: const Color.fromARGB(255, 88, 145, 209),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
