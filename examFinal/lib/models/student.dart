// --- Data Model ---
class Student {
  final int id;
  String name;
  String phone;
  double latitude; // Changed from LatLng
  double longitude; // Changed from LatLng

  Student({
    this.id = 1, // Using a fixed ID for this example
    this.name = '',
    this.phone = '',
    this.latitude = 37.422, // Default to Googleplex
    this.longitude = -122.084, // Default to Googleplex
  });

  // Factory constructor to create a Student from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      // Directly parse latitude and longitude
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  // Method to convert a Student to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
