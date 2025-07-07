<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// Database configuration (gunakan SQLite untuk kemudahan)
$db_path = 'attendance.db';

// Create database if not exists
if (!file_exists($db_path)) {
    $pdo = new PDO("sqlite:$db_path");
    
    // Create tables
    $pdo->exec("
        CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            nis TEXT NOT NULL,
            class_name TEXT NOT NULL
        )
    ");
    
    $pdo->exec("
        CREATE TABLE attendance (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            student_id INTEGER,
            date TEXT NOT NULL,
            status TEXT NOT NULL,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (student_id) REFERENCES students (id)
        )
    ");
    
    // Insert sample data
    $sample_students = [
        ['Ahmad Fauzi', '2024001', 'PPLG4'],
        ['Budi Santoso', '2024002', 'PPLG4'],
        ['Citra Dewi', '2024003', 'PPLG4'],
        ['Dewi Sartika', '2024004', 'PPLG4'],
        ['Eko Prasetyo', '2024005', 'PPLG4'],
    ];
    
    $stmt = $pdo->prepare("INSERT INTO students (name, nis, class_name) VALUES (?, ?, ?)");
    foreach ($sample_students as $student) {
        $stmt->execute($student);
    }
} else {
    $pdo = new PDO("sqlite:$db_path");
}

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        if (isset($_GET['action'])) {
            switch ($_GET['action']) {
                case 'students':
                    $stmt = $pdo->query("SELECT * FROM students ORDER BY name");
                    $students = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    echo json_encode(['success' => true, 'data' => $students]);
                    break;
                    
                case 'attendance':
                    $date = $_GET['date'] ?? date('Y-m-d');
                    $stmt = $pdo->prepare("
                        SELECT s.name, s.nis, a.status, a.timestamp
                        FROM students s
                        LEFT JOIN attendance a ON s.id = a.student_id AND a.date = ?
                        ORDER BY s.name
                    ");
                    $stmt->execute([$date]);
                    $attendance = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    echo json_encode(['success' => true, 'data' => $attendance]);
                    break;
                    
                default:
                    echo json_encode(['success' => false, 'message' => 'Invalid action']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Action required']);
        }
        break;
        
    case 'POST':
        $input = json_decode(file_get_contents('php://input'), true);
        
        if (isset($input['action'])) {
            switch ($input['action']) {
                case 'save_attendance':
                    if (isset($input['date']) && isset($input['attendance_data'])) {
                        $date = $input['date'];
                        $attendance_data = $input['attendance_data'];
                        
                        // Begin transaction
                        $pdo->beginTransaction();
                        
                        try {
                            // Delete existing attendance for this date
                            $stmt = $pdo->prepare("DELETE FROM attendance WHERE date = ?");
                            $stmt->execute([$date]);
                            
                            // Insert new attendance data
                            $stmt = $pdo->prepare("
                                INSERT INTO attendance (student_id, date, status) 
                                VALUES (?, ?, ?)
                            ");
                            
                            foreach ($attendance_data as $student_id => $status) {
                                $stmt->execute([$student_id, $date, $status]);
                            }
                            
                            $pdo->commit();
                            echo json_encode(['success' => true, 'message' => 'Attendance saved successfully']);
                            
                        } catch (Exception $e) {
                            $pdo->rollback();
                            echo json_encode(['success' => false, 'message' => 'Error saving attendance: ' . $e->getMessage()]);
                        }
                    } else {
                        echo json_encode(['success' => false, 'message' => 'Missing required data']);
                    }
                    break;
                    
                default:
                    echo json_encode(['success' => false, 'message' => 'Invalid action']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Action required']);
        }
        break;
        
    default:
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
}
?> 