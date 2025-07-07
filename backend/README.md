# Backend PHP - Aplikasi Absensi PPLG4

Backend API untuk aplikasi absensi kelas PPLG4 menggunakan PHP dan SQLite.

## Setup

1. **Install XAMPP/Laragon** atau web server dengan PHP
2. **Copy folder backend** ke htdocs (XAMPP) atau www (Laragon)
3. **Akses via browser**: `http://localhost/backend/`

## Database

- Menggunakan SQLite (`attendance.db`)
- Database akan dibuat otomatis saat pertama kali diakses
- Tabel: `students`, `attendance`

## API Endpoints

### GET /index.php?action=students
Mengambil daftar semua siswa
```json
{
  "success": true,
  "data": [
    {
      "id": "1",
      "name": "Ahmad Fauzi",
      "nis": "2024001",
      "class_name": "PPLG4"
    }
  ]
}
```

### GET /index.php?action=attendance&date=2024-01-15
Mengambil data absensi per tanggal
```json
{
  "success": true,
  "data": [
    {
      "name": "Ahmad Fauzi",
      "nis": "2024001",
      "status": "present",
      "timestamp": "2024-01-15 08:00:00"
    }
  ]
}
```

### POST /index.php
Menyimpan data absensi
```json
{
  "action": "save_attendance",
  "date": "2024-01-15",
  "attendance_data": {
    "1": "present",
    "2": "absent",
    "3": "present"
  }
}
```

## Cara Menjalankan

1. Start Apache di XAMPP/Laragon
2. Buka browser: `http://localhost/backend/`
3. Test API dengan Postman atau tools lainnya

## Integrasi dengan Flutter

Flutter akan mengirim HTTP request ke endpoint ini untuk:
- Mengambil data siswa
- Menyimpan data absensi
- Mengambil riwayat absensi 