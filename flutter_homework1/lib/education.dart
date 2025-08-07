import 'package:flutter/material.dart';

void main() {
  runApp(const Education());
}

class Education extends StatelessWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        color: const Color.fromARGB(255, 247, 242, 220),
        height: screenHeight,
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'การศึกษา',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),

                    Card(
                      color: Colors.white30,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.school, color: Colors.red),
                        title: Text('มัธยมต้น'),
                        subtitle: Text('โรงเรียน ถาวรานุกูล'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Card(
                      color: Colors.white30,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.school_outlined,
                          color: Colors.blueGrey,
                        ),
                        title: Text('มัธยมปลาย'),
                        subtitle: Text('วิทยาลัยเทคนิคสมุทรสงคราม'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Card(
                      color: Colors.white30,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.account_balance, color: Colors.red),
                        title: Text('วิทยาลัย'),
                        subtitle: Text('วิทยาลัยเทคนิคสมุทรสงคราม'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Card(
                      color: Colors.white30,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.school_rounded,
                          color: Colors.orangeAccent,
                        ),
                        title: Text('มหาวิทยาลัย'),
                        subtitle: Text('มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
