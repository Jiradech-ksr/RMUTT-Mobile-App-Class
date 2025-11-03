import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';
import '../constants.dart'; // Imports the apiBaseUrl

class ApiService {
  // --- (GET) Fetch ALL Students ---
  Future<List<Student>> fetchAllStudents() async {
    final response = await http.get(
      Uri.parse('$apiBaseUrl/api.php'), // No ID = fetch all
    );

    if (response.statusCode == 200) {
      // Decode the response body (which is a JSON string)
      final List<dynamic> jsonData = json.decode(response.body);

      // Map the JSON list to a List<Student>
      return jsonData.map((json) => Student.fromJson(json)).toList();
    } else {
      // Throw an error if the server response wasn't OK
      throw Exception('Failed to load students: ${response.body}');
    }
  }

  // --- (GET) Fetch a SINGLE Student (Not currently used, but here if needed) ---
  Future<Student> fetchStudentDetails(int id) async {
    // Note: /api.php?id=1
    final response = await http.get(Uri.parse('$apiBaseUrl/api.php?id=$id'));

    if (response.statusCode == 200) {
      // Decode the single JSON object
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load student details: ${response.body}');
    }
  }

  // --- (POST) Save Student (Handles BOTH Create and Update) ---
  Future<void> saveStudentDetails(Student student) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/api.php'), // No ID in URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // The student.toJson() method handles whether to include the ID
      body: json.encode(student.toJson()),
    );

    // 200 = OK (for update), 201 = Created (for insert)
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save student details: ${response.body}');
    }
  }

  // --- (DELETE) Delete a Student ---
  Future<void> deleteStudent(int id) async {
    // Note: /api.php?id=1
    final response = await http.delete(Uri.parse('$apiBaseUrl/api.php?id=$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete student: ${response.body}');
    }
  }
}
