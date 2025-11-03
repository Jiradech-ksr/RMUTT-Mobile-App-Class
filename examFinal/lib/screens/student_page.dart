import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs

import '../models/student.dart';
import '../services/api_service.dart';
import 'add_student_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Use the ApiService instance
  final ApiService _apiService = ApiService();

  // Future to hold the list of students
  late Future<List<Student>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future by calling the fetch method
    _studentsFuture = _apiService.fetchAllStudents();
  }

  // --- Data Fetching ---
  void _refreshStudentList() {
    setState(() {
      _studentsFuture = _apiService.fetchAllStudents();
    });
  }

  // --- UI Building ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Roster'),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      body: FutureBuilder<List<Student>>(
        future: _studentsFuture,
        builder: (context, snapshot) {
          // --- 1. Loading State ---
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // --- 2. Error State ---
          if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          }

          // --- 3. Empty State ---
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyState();
          }

          // --- 4. Success State (Data Loaded) ---
          final students = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async => _refreshStudentList(),
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 80,
              ), // Padding for FAB
              itemCount: students.length,
              itemBuilder: (context, index) {
                return _buildStudentCard(students[index]);
              },
            ),
          );
        },
      ),
      // --- Add Student Button ---
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddStudentPage,
        icon: const Icon(Icons.add),
        label: const Text("Add Student"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
    );
  }

  // --- Widget for Error State ---
  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off_rounded, size: 80, color: Colors.red.shade300),
            const SizedBox(height: 20),
            const Text(
              'Failed to Load Students',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Please check your connection and that the server is running. Tap to retry.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 10),
            Text(
              'Error details: $error',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _refreshStudentList,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget for Empty State ---
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_search_rounded,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Students Found',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Tap the "+" button to add the first student!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget for a Single Student Card ---
  Widget _buildStudentCard(Student student) {
    return Card(
      // Using the CardTheme from main.dart
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            student.name.isNotEmpty ? student.name[0].toUpperCase() : '?',
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          student.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(student.phone),
        trailing: Row(
          mainAxisSize:
              MainAxisSize.min, // So the Row doesn't take all the space
          children: [
            // --- Map Button ---
            IconButton(
              icon: Icon(Icons.map_rounded, color: Colors.green.shade600),
              onPressed: () =>
                  _openGoogleMaps(student.latitude, student.longitude),
              tooltip: 'Open in Google Maps',
            ),
            // --- Remove Button ---
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
              onPressed: () => _confirmRemoveStudent(student),
              tooltip: 'Remove Student',
            ),
          ],
        ),
      ),
    );
  }

  // --- Actions & Navigation ---

  // --- Open Google Maps ---
  Future<void> _openGoogleMaps(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      _showSnackBar('This student has no location data.', isError: true);
      return;
    }

    // Universal Google Maps URL
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showSnackBar('Could not open Google Maps.', isError: true);
    }
  }

  // --- Navigate to Add Student Page ---
  Future<void> _navigateToAddStudentPage() async {
    // Wait for the AddStudentPage to close, and check if it returns 'true'
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddStudentPage()),
    );

    // If the page returned 'true' (meaning a student was added),
    // refresh the list.
    if (result == true) {
      _refreshStudentList();
    }
  }

  // --- Show Confirmation Dialog for Removing ---
  Future<void> _confirmRemoveStudent(Student student) async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Remove Student?'),
          content: Text(
            'Are you sure you want to remove ${student.name}? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Remove'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
                _removeStudent(student.id); // Call the delete function
              },
            ),
          ],
        );
      },
    );
  }

  // --- Call API to Remove Student ---
  Future<void> _removeStudent(int? studentId) async {
    if (studentId == null) return;

    try {
      // Call the API
      await _apiService.deleteStudent(studentId);

      // Show success message
      _showSnackBar('Student removed successfully.', isError: false);

      // Refresh the list to show the student is gone
      _refreshStudentList();
    } catch (e) {
      // Show error message
      _showSnackBar('Failed to remove student. $e', isError: true);
    }
  }

  // --- Utility to show a SnackBar ---
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return; // Check if the widget is still in the tree
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
      ),
    );
  }
}
