import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../models/student.dart';

class AttendanceProvider with ChangeNotifier {
  List<Student> _students = [];
  Set<String> _presentStudents = {};
  String _currentDate = '';

  AttendanceProvider() {
    _loadStudents();
    _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  List<Student> get students => _students;
  Set<String> get presentStudents => _presentStudents;
  String get currentDate => _currentDate;

  void _loadStudents() {
    // Data dummy siswa PPLG4
    _students = [
      Student(id: '1', name: 'Ahmad Fauzi', nis: '2024001', className: 'PPLG4'),
      Student(id: '2', name: 'Budi Santoso', nis: '2024002', className: 'PPLG4'),
      Student(id: '3', name: 'Citra Dewi', nis: '2024003', className: 'PPLG4'),
      Student(id: '4', name: 'Dewi Sartika', nis: '2024004', className: 'PPLG4'),
      Student(id: '5', name: 'Eko Prasetyo', nis: '2024005', className: 'PPLG4'),
      Student(id: '6', name: 'Fitri Handayani', nis: '2024006', className: 'PPLG4'),
      Student(id: '7', name: 'Gunawan Setiawan', nis: '2024007', className: 'PPLG4'),
      Student(id: '8', name: 'Hesti Wulandari', nis: '2024008', className: 'PPLG4'),
      Student(id: '9', name: 'Indra Kusuma', nis: '2024009', className: 'PPLG4'),
      Student(id: '10', name: 'Joko Widodo', nis: '2024010', className: 'PPLG4'),
      Student(id: '11', name: 'Kartika Sari', nis: '2024011', className: 'PPLG4'),
      Student(id: '12', name: 'Lukman Hakim', nis: '2024012', className: 'PPLG4'),
      Student(id: '13', name: 'Maya Indah', nis: '2024013', className: 'PPLG4'),
      Student(id: '14', name: 'Nugroho Pratama', nis: '2024014', className: 'PPLG4'),
      Student(id: '15', name: 'Oktavia Putri', nis: '2024015', className: 'PPLG4'),
    ];
  }

  bool isStudentPresent(String studentId) {
    return _presentStudents.contains(studentId);
  }

  void toggleAttendance(String studentId) {
    if (_presentStudents.contains(studentId)) {
      _presentStudents.remove(studentId);
    } else {
      _presentStudents.add(studentId);
    }
    notifyListeners();
  }

  void markAllPresent() {
    _presentStudents.clear();
    for (var student in _students) {
      _presentStudents.add(student.id);
    }
    notifyListeners();
  }

  void clearAttendance() {
    _presentStudents.clear();
    notifyListeners();
  }

  Future<void> saveAttendance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final attendanceData = {
        'date': _currentDate,
        'present_students': _presentStudents.toList(),
        'total_students': _students.length,
        'present_count': _presentStudents.length,
      };
      
      await prefs.setString('attendance_${_currentDate.replaceAll('/', '_')}', 
                           attendanceData.toString());
    } catch (e) {
      print('Error saving attendance: $e');
    }
  }

  Future<void> loadAttendance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'attendance_${_currentDate.replaceAll('/', '_')}';
      final data = prefs.getString(key);
      
      if (data != null) {
        // Parse data dari SharedPreferences
        // Implementasi parsing sederhana
        _presentStudents.clear();
        // TODO: Implement proper parsing
        notifyListeners();
      }
    } catch (e) {
      print('Error loading attendance: $e');
    }
  }

  int get presentCount => _presentStudents.length;
  int get absentCount => _students.length - _presentStudents.length;
  double get attendancePercentage => 
      _students.isEmpty ? 0 : (_presentStudents.length / _students.length) * 100;
} 