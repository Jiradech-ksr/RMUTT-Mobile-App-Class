import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching maps
import '../models/student.dart';
import '../services/api_service.dart';

// --- Student Details Page ---
class StudentDetailsPage extends StatefulWidget {
  final int studentId;
  const StudentDetailsPage({super.key, required this.studentId});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  // State variables
  Student _student = Student(); // Default empty student
  bool _isLoading = true;
  String _errorMessage = '';

  // Service for API calls
  late final ApiService _apiService;

  // Controllers for text fields
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _latController; // For Latitude
  late final TextEditingController _lngController; // For Longitude

  @override
  void initState() {
    super.initState();
    _apiService = ApiService(); // Initialize the service
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _latController = TextEditingController();
    _lngController = TextEditingController();
    _fetchStudentDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  // --- Logic: Fetch Data ---
  Future<void> _fetchStudentDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      // Call the service
      final student = await _apiService.fetchStudentDetails(widget.studentId);

      // Update UI state
      setState(() {
        _student = student;
        _nameController.text = _student.name;
        _phoneController.text = _student.phone;
        // Update new text fields
        _latController.text = _student.latitude.toString();
        _lngController.text = _student.longitude.toString();
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load details: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- Logic: Save Data ---
  Future<void> _saveStudentDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Update student object from controllers
    final updatedStudent = Student(
      id: _student.id,
      name: _nameController.text,
      phone: _phoneController.text,
      // Parse location from text fields
      latitude: double.tryParse(_latController.text) ?? _student.latitude,
      longitude: double.tryParse(_lngController.text) ?? _student.longitude,
    );

    try {
      // Call the service
      await _apiService.saveStudentDetails(updatedStudent);

      // Update the local student object in case we save again
      setState(() {
        _student = updatedStudent;
      });

      // Show a success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Details saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to save details: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- Logic: Method to launch Google Maps ---
  Future<void> _launchMapsApp() async {
    final double lat =
        double.tryParse(_latController.text) ?? _student.latitude;
    final double lng =
        double.tryParse(_lngController.text) ?? _student.longitude;

    // Universal Google Maps URL
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Show an error if the URL can't be launched
      setState(() {
        _errorMessage =
            'Could not launch Google Maps. Please ensure you have a map application installed.';
      });
    }
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body:
          _isLoading &&
              _student
                  .name
                  .isEmpty // Show loader only on initial load
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                        : const Icon(Icons.save),
                    label: const Text('Save Details'),
                    onPressed: _isLoading ? null : _saveStudentDetails,
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
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }

  // --- Location Card (replaces map) ---
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Button to open maps
            OutlinedButton.icon(
              icon: const Icon(Icons.open_in_new),
              label: const Text('Open in Google Maps'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  44,
                ), // Make it full width
              ),
              onPressed: _launchMapsApp,
            ),
          ],
        ),
      ),
    );
  }
}
