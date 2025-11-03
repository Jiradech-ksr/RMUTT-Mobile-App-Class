<?php
// --- Database Connection ---
// !! IMPORTANT !!
// Update these 4 lines with your MySQL details from XAMPP
$servername = "localhost";
$username = "root";      // Default XAMPP username
$password = "";          // Default XAMPP password is blank
$dbname = "student_db";  // The database name you created

// --- Headers ---
// Allow requests from any origin (Flutter app)
Header("Access-Control-Allow-Origin: *");
// Set the content type to JSON
Header("Content-Type: application/json; charset=UTF-8");
// Allow specific HTTP methods
Header("Access-Control-Allow-Methods: GET, POST, DELETE, OPTIONS");
// Allow specific headers
Header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// --- FIX for String vs. Int Error ---
// Enable error reporting for MySQLi
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
// --- End of Fix ---

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// --- *** THIS IS THE LINE THAT FIXES THE TYPE ERROR *** ---
// Tell MySQLi to return numbers as numbers, not strings
if (function_exists('mysqli_fetch_all')) {
    $conn->options(MYSQLI_OPT_INT_AND_FLOAT_NATIVE, 1);
}
// --- *** END OF FIX *** ---


// Check connection
if ($conn->connect_error) {
    // Send a 500 Internal Server Error response
    http_response_code(500);
    echo json_encode(['error' => 'Connection failed: ' . $conn->connect_error]);
    die();
}

// Get the HTTP method (GET, POST, DELETE)
$method = $_SERVER['REQUEST_METHOD'];

// Handle pre-flight OPTIONS request (for CORS)
if ($method == 'OPTIONS') {
    http_response_code(200);
    exit();
}

// --- Main API Logic (CRUD) ---
switch ($method) {
    // --- (R)EAD ---
    case 'GET':
        if (isset($_GET['id'])) {
            // Get ONE student by ID
            $id = intval($_GET['id']);
            $sql = "SELECT * FROM students WHERE id = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                echo json_encode($result->fetch_assoc());
            } else {
                http_response_code(404);
                echo json_encode(['message' => 'Student not found']);
            }
        } else {
            // Get ALL students
            $sql = "SELECT * FROM students";
            $result = $conn->query($sql);
            $students = [];
            if ($result->num_rows > 0) {
                // Use mysqli_fetch_all for cleaner code
                $students = mysqli_fetch_all($result, MYSQLI_ASSOC);
            }
            echo json_encode($students);
        }
        break;

    // --- (C)REATE ---
    // This block is now simplified to ONLY insert new students.
    case 'POST':
        // Get the JSON data from the request body
        $data = json_decode(file_get_contents('php://input'), true);

        // Check if data is valid
        if ($data === null || empty($data['name'])) {
            http_response_code(400); // Bad Request
            echo json_encode(['message' => 'Invalid JSON data or missing name']);
            break;
        }

        // --- INSERT (This is now the only action for POST) ---
        $sql = "INSERT INTO students (name, phone, latitude, longitude) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        
        // Use null coalescing operator (??) to provide defaults if values are missing
        $name = $data['name'];
        $phone = $data['phone'] ?? null;
        $latitude = $data['latitude'] ?? null;
        $longitude = $data['longitude'] ?? null;

        $stmt->bind_param(
            "ssss",
            $name,
            $phone,
            $latitude,
            $longitude
        );
        
        if ($stmt->execute()) {
            http_response_code(201); // Created
            echo json_encode(['message' => 'Student added successfully', 'id' => $conn->insert_id]);
        } else {
            http_response_code(500);
            echo json_encode(['message' => 'Failed to add student: ' . $stmt->error]);
        }
        break;

    // --- (D)ELETE ---
    case 'DELETE':
        if (isset($_GET['id'])) {
            $id = intval($_GET['id']);
            $sql = "DELETE FROM students WHERE id = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("i", $id);
            if ($stmt->execute()) {
                if ($stmt->affected_rows > 0) {
                    http_response_code(200); // OK
                    echo json_encode(['message' => 'Student removed successfully']);
                } else {
                    http_response_code(404); // Not Found
                    echo json_encode(['message' => 'Student not found or already removed']);
                }
            } else {
                http_response_code(500);
                echo json_encode(['message' => 'Failed to remove student: ' . $stmt->error]);
            }
        } else {
            http_response_code(400); // Bad Request
            echo json_encode(['message' => 'No student ID provided for deletion']);
        }
        break;

    default:
        // Invalid HTTP method
        http_response_code(405); // Method Not Allowed
        echo json_encode(['message' => 'Invalid request method']);
        break;
}

// Close the connection
$conn->close();
?>

