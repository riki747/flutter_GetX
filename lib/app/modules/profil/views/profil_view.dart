import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                // FOTO    =======================================================================================================
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("images/profil.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // NAMA DAN ROLE ==============================================================================================
                Obx(
                  () => Text(
                    controller.nim.value,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                Obx(
                  () => Text(
                    controller.role.value,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                SizedBox(height: 20),

                // CARD DATA   ================================================================================================
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person, color: Colors.black),
                          title: Text("Nama"),
                          subtitle: Obx(() => Text(controller.name.value)),
                        ),
                        Divider(),

                        ListTile(
                          leading: Icon(Icons.email, color: Colors.orange),
                          title: Text("Email"),
                          subtitle: Obx(() => Text(controller.email.value)),
                        ),
                        Divider(),

                        ListTile(
                          leading: Icon(Icons.phone, color: Colors.black),
                          title: Text("Phone"),
                          subtitle: Obx(() => Text(controller.phone.value)),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 25),

                // BUTTON UBAH  ===============================================================================================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      controller.ubahProfil();
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      "Ubah Profil",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // BUTTON SIMPAN ==============================================================================================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      controller.updateProfile(
                        controller.name.value,
                        controller.email.value,
                        controller.phone.value,
                      );
                    },
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text(
                      "Simpan Perubahan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // BUTTON HAPUS ===============================================================================================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      controller.deleteProfile();
                    },
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text(
                      "Hapus Akun",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BUTTON UBAH FOTO  ================================================================================================
          Positioned(
            top: 120,
            right: 180,
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
                  print("klik");
                  controller.ubahfoto();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
