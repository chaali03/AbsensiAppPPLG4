# AbsensiAppPPLG4

Project aplikasi absensi kelas berbasis Flutter (mobile) dengan backend PHP (API).

## Struktur Project

- `lib/` : Source code aplikasi mobile Flutter
- `backend/` : Source code backend PHP (API)

## Setup Project

### 1. Install Flutter SDK
1. Download Flutter SDK dari [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. Ekstrak ke `C:\src\flutter`
3. Tambahkan `C:\src\flutter\bin` ke PATH Windows
4. Jalankan `flutter doctor` untuk verifikasi

### 2. Install Dependencies Flutter
```bash
flutter pub get
```

### 3. Setup Backend PHP
1. Install XAMPP/Laragon
2. Copy folder `backend/` ke `htdocs/` (XAMPP) atau `www/` (Laragon)
3. Start Apache server

## Menjalankan Aplikasi

### Flutter App
```bash
# Di folder project
flutter run
```

### Backend PHP
1. Start Apache di XAMPP/Laragon
2. Akses: `http://localhost/backend/`

## Fitur Aplikasi

- ✅ Daftar siswa PPLG4 (15 siswa)
- ✅ Absensi per siswa (tap untuk toggle)
- ✅ Absen semua siswa sekaligus
- ✅ Reset absensi
- ✅ Simpan data ke local storage
- ✅ Backend API untuk penyimpanan server
- ✅ Tampilan modern dengan Material Design 3

## Data Siswa PPLG4

Aplikasi sudah berisi data dummy 15 siswa PPLG4:
1. Ahmad Fauzi (2024001)
2. Budi Santoso (2024002)
3. Citra Dewi (2024003)
4. Dewi Sartika (2024004)
5. Eko Prasetyo (2024005)
6. Fitri Handayani (2024006)
7. Gunawan Setiawan (2024007)
8. Hesti Wulandari (2024008)
9. Indra Kusuma (2024009)
10. Joko Widodo (2024010)
11. Kartika Sari (2024011)
12. Lukman Hakim (2024012)
13. Maya Indah (2024013)
14. Nugroho Pratama (2024014)
15. Oktavia Putri (2024015)

## Cara Kerja
- Flutter mengirim data absensi ke backend PHP melalui HTTP request
- Backend PHP menyimpan data ke database SQLite
- Data juga disimpan di local storage Flutter untuk offline access

## Next Steps
- [ ] Integrasi Flutter dengan backend PHP
- [ ] Fitur export data ke Excel/PDF
- [ ] Fitur login admin
- [ ] Dashboard statistik absensi 