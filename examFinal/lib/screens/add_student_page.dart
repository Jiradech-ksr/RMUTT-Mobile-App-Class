import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';

// --- Add Student Page ---
class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  // State variables
  bool _isLoading = false;
  String _errorMessage = '';

  // Service for API calls
  late final ApiService _apiService;

  // Controllers for text fields
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _latController;
  late final TextEditingController _lngController;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    // Set default location to Googleplex (or any default you like)
    _latController = TextEditingController(text: '37.422');
    _lngController = TextEditingController(text: '-122.084');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  // --- Logic: Save New Student ---
  Future<void> _saveNewStudent() async {
    // Basic validation
    if (_nameController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a name for the student.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Create a new student object
    // ** Note: We do NOT provide an ID **
    final newStudent = Student(
      name: _nameController.text,
      phone: _phoneController.text,
      latitude: double.tryParse(_latController.text) ?? 37.422,
      longitude: double.tryParse(_lngController.text) ?? -122.084,
    );

    try {
      // Call the service. Because newStudent.id is null,
      // the api_service will send a request that the PHP
      // script will interpret as an INSERT.
      await _apiService.saveStudentDetails(newStudent);

      // If successful, show a success message and pop the screen
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New student added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Go back to the home page
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to save student: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Student'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Error Message Display ---
            if (_errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red.shade900),
                ),
              ),

            // --- Form Fields ---
            _buildFormCard(),

            // --- Location Card ---
            _buildLocationCard(),

            // --- Save Button ---
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: _isLoading
                  ? Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : const Icon(Icons.person_add_alt_1),
              label: const Text('Save New Student'),
              onPressed: _isLoading ? null : _saveNewStudent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home Location',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latController,
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                      prefixIcon: Icon(Icons.map_outlined),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _lngController,
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      prefixIcon: Icon(Icons.explore_outlined),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
