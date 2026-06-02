import 'package:flutter/material.dart';
import 'package:flutter_project_1/Page/home.dart';
import 'package:get/get.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profil"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        // automaticallyImplyLeading: false,
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 30),
            child: Column(
              children: [
                ClipOval(
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    color: Colors.grey,
                  ),
                ),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Nama Lengkap",
                            hint: Text("Rhiki Sulistiyo"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            hint: Text("rhikisullistiyo115@gmail.com"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hint: Text("******"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            // ScaffoldMessenger.of(
                            //   context,
                            // ).showSnackBar(SnackBar(content: Text("Pesan")));                        penggunaan pada flutter biasa
                            Get.snackbar( //                                            ============================= 5 =============================
                              "Berhasil",
                              "Data telah disimpan!",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Simpan Perubahan",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.red,
                            ),
                          ),
                          onPressed: () {
                            // showDialog(
                            //   context: context,
                            //   builder: (context) => AlertDialog(
                            //     title: Text("Warning"),
                            //     content: Text("Yakin?"),   ),  );                                    penggunaan pada flutter biasa
                            Get.defaultDialog(//                                         ============================= 6 =============================
                              title: "Konfirmasi",
                              middleText:
                                  "Apakah Anda yakin ingin menghapus akun ini?",
                              textConfirm: "Ya",
                              textCancel: "Tidak",
                              onConfirm: () {
                                Get.to(Homepage());
                              },
                              onCancel: () {
                                Get.to(Profil());
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 30,
                              right: 30,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_forever_sharp,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Hapus Akun",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 140,
            right: 200,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: IconButton(
                icon: const Icon(Icons.edit, size: 20, color: Colors.white),
                onPressed: () {
                  // showModalBottomSheet(
                  // context: context,
                  // builder: (context) => Container(
                  // child: Text("Hello"), ), );                                                        penggunaan pada flutter biasa
                  Get.bottomSheet(//                                                     ============================= 7 =============================
                    Container(
                      padding: const EdgeInsets.only(top: 12, bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          // Ini bagian Shade
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1,
                            spreadRadius: 20,
                          ),
                        ],
                      ),

                      child: Wrap(
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 10,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(bottom: 5),
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
                              // Navigator.pop(context);                                                penggunaan pada flutter biasa
                              Get.back(); //                                            ============================= 8 =============================
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Pilih dari Galeri'),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
