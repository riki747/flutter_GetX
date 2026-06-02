import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  //TODO: Implement ProfilController
  var name = "Rhiki Sulistiyo".obs;
  var nim = "230901115".obs;
  var role = "Mahasiswa 6B".obs;
  var email = "rhikisulistiyo115@email.com".obs;
  var phone = "0895339162828".obs;

  void updateProfile(String newName, String newEmail, String newPhone) {
    // name.value = newName;
    // email.value = newEmail;
    // phone.value = newPhone;

    Get.snackbar(
      "Berhasil",
      "Profil berhasil diperbarui",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deleteProfile() {
    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Yakin mau hapus profil?",
      textConfirm: "Ya",
      textCancel: "Tidak",
      onConfirm: () {
        Get.back();

        Get.back(result: true);

        Future.delayed(Duration(milliseconds: 50), () {
          Get.snackbar(
            "Berhasil",
            "Akun berhasil dihapus",
            snackPosition: SnackPosition.BOTTOM,
          );
        });
      },
    );
  }

  void ubahProfil() {
    Get.defaultDialog(
      title: "Ubah Profil",
      content: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => name.value = value,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              onChanged: (value) => email.value = value,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              onChanged: (value) => phone.value = value,
              decoration: InputDecoration(labelText: "Telepon"),
            ),
          ],
        ),
      ),
      textConfirm: "Simpan",
      textCancel: "Batal",
      onConfirm: () {
        Get.back();
        Get.snackbar("Berhasil", "Profil berhasil diubah");
      },
    );
  }

  void ubahfoto() {
  //get botton
   Get.bottomSheet(
  Container(
    padding: const EdgeInsets.only(top: 12, bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Wrap(
      children: [
        Center(
          child: Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Ambil Foto'),
          onTap: () {
            Get.back();
            Get.snackbar("Maaf nyakk", "Fitur belum tersedia nihhh",
            snackPosition: SnackPosition.BOTTOM,);
            print("Ambil Foto");
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_library),
          title: Text('Galeri'),
          onTap: () {
            Get.back();
            Get.snackbar("Maaf nyakkk", "Fitur belum tersedia nihhh",
            snackPosition: SnackPosition.BOTTOM,);
            print("Pilih dari Galeri");
          },
        ),
      ],
    ),
  ),
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
);
   }

}
