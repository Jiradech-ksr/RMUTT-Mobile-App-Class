import 'package:flutter/material.dart';
import 'screens/student_page.dart';
import 'screens/odd_number_page.dart'; // New blank page
import 'screens/auto_return_change_page.dart'; // New blank page

void main() {
  runApp(const MyApp());
}

// --- Main App Widget ---
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      theme: ThemeData(
        // Your existing theme
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: const MainNavigationShell(), // This is the new home
    );
  }
}

// --- New Navigation Shell Widget ---
class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;

  // List of the three pages
  static const List<Widget> _pages = <Widget>[
    // Your existing student list
    OddNumbersPage(), // New blank page 1
    ChangeCalculatorPage(),
    HomePage(), // New blank page 2
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body is now the currently selected page
      body: IndexedStack(index: _selectedIndex, children: _pages),

      // The BottomNavigationBar switches the page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.description_rounded),
            label: 'Odd Numbers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Money',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Students',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade700,
        onTap: _onItemTapped,
      ),
    );
  }
}
