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

### check task 
https://docs.google.com/spreadsheets/d/1OuiNeTZrPbrhucLVVi8_miX0y9Iv4VYgoZpE0PcRG9g/edit?hl=id&pli=1&gid=1150608600#gid=1150608600