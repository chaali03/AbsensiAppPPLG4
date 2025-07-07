import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../models/student.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi PPLG4'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<AttendanceProvider>(
        builder: (context, attendanceProvider, child) {
          return Column(
            children: [
              // Header dengan tanggal
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tanggal: ${attendanceProvider.currentDate}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total: ${attendanceProvider.students.length} Siswa',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              
              // Daftar siswa
              Expanded(
                child: ListView.builder(
                  itemCount: attendanceProvider.students.length,
                  itemBuilder: (context, index) {
                    final student = attendanceProvider.students[index];
                    final isPresent = attendanceProvider.isStudentPresent(student.id);
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isPresent ? Colors.green : Colors.grey,
                          child: Text(
                            student.name[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(student.name),
                        subtitle: Text('NIS: ${student.nis}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isPresent ? 'Hadir' : 'Belum Absen',
                              style: TextStyle(
                                color: isPresent ? Colors.green : Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              isPresent ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: isPresent ? Colors.green : Colors.grey,
                            ),
                          ],
                        ),
                        onTap: () {
                          attendanceProvider.toggleAttendance(student.id);
                        },
                      ),
                    );
                  },
                ),
              ),
              
              // Tombol aksi
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          attendanceProvider.markAllPresent();
                        },
                        icon: const Icon(Icons.check_box),
                        label: const Text('Absen Semua'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          attendanceProvider.clearAttendance();
                        },
                        icon: const Icon(Icons.clear_all),
                        label: const Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AttendanceProvider>().saveAttendance();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data absensi berhasil disimpan!')),
          );
        },
        tooltip: 'Simpan Absensi',
        child: const Icon(Icons.save),
      ),
    );
  }
} 