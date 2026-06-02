# 📱 Flutter GetX Basic Implementation

Project ini merupakan implementasi sederhana penggunaan **GetX** pada Flutter, dengan fokus pada:

* State Management
* Navigation
* UI Feedback

---

## 🎯 Tujuan

Memahami konsep dasar GetX dengan membagi implementasi berdasarkan fungsi utama:

* State & Dependency → di halaman Home
* UI Feedback → di halaman Profil

---

## 📂 Struktur Halaman

* `main.dart` → Entry point aplikasi
* `home.dart` → State management & navigation
* `profil.dart` → UI feedback (interaksi user)

---

## 🏠 Halaman Home

Berisi implementasi core GetX:

### ✅ Get.put()

Digunakan untuk inisialisasi controller

```dart
final controller = Get.put(MyController());
```

### ✅ .obs

Membuat variabel menjadi reactive

```dart
var count = 0.obs;
```

### ✅ Obx

Widget yang otomatis update saat data berubah

```dart
Obx(() => Text("${controller.count}"));
```

### ✅ Get.to()

Navigasi ke halaman lain

```dart
Get.to(Profil());
```

---

## 👤 Halaman Profil

Berisi implementasi UI feedback menggunakan GetX:

### ✅ Get.snackbar()

Menampilkan notifikasi

```dart
Get.snackbar("Berhasil", "Data telah disimpan!");
```

### ✅ Get.defaultDialog()

Menampilkan dialog konfirmasi

```dart
Get.defaultDialog(
  title: "Konfirmasi",
  middleText: "Apakah Anda yakin?",
);
```

### ✅ Get.bottomSheet()

Menampilkan pilihan dari bawah layar

```dart
Get.bottomSheet(Container());
```

### ✅ Get.back()

Menutup halaman / dialog / bottom sheet

```dart
Get.back();
```

---

## 🔄 Alur Aplikasi

1. Aplikasi dimulai dari **Home**
2. State dikelola menggunakan `.obs` dan `Obx`
3. User navigasi ke halaman **Profil** menggunakan `Get.to()`
4. Di halaman Profil:

   * User bisa membuka bottom sheet
   * Menampilkan snackbar
   * Menampilkan dialog konfirmasi
5. Navigasi kembali menggunakan `Get.back()`

---

## 🔄 Perbandingan dengan Flutter Biasa

| Fitur       | Flutter Biasa        | GetX              |
| ----------- | -------------------- | ----------------- |
| Navigation  | Navigator.push       | Get.to            |
| Back        | Navigator.pop        | Get.back          |
| Snackbar    | ScaffoldMessenger    | Get.snackbar      |
| Dialog      | showDialog           | Get.defaultDialog |
| BottomSheet | showModalBottomSheet | Get.bottomSheet   |

---

## 💡 Kelebihan GetX

* Tidak membutuhkan BuildContext
* Sintaks lebih singkat
* Menggabungkan state management, routing, dan dependency injection

---

## 📌 Kesimpulan

Dengan pembagian ini, GetX dapat dipahami lebih jelas:

* **Home → logika & state**
* **Profil → interaksi & feedback**

Sehingga aplikasi lebih terstruktur dan mudah dikembangkan.

---

## 👨‍💻 Author
Nama: [Rhiki Sulistiyo]
