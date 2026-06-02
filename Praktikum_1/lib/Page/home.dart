import 'package:flutter/material.dart';
import 'package:flutter_project_1/Page/profil.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs; //                                   ==================== 1 ========================

  void increment() {
    count++;
  }

  //dekremen
  void decrement() {
    count--;
  }
}

class Homepage extends StatelessWidget {
  final CounterController counterController =
      Get.put//                                             ==================== 2 ========================
      (CounterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(Profil()); //                          ====================== 3 ======================
              // Navigator.push //                                    penggunaan pada flutter biasa
            },
            icon: Icon(Icons.person_sharp, color: Colors.black),
          ),
        ],
      ),
      
      body: Container(
        decoration: BoxDecoration(
          //  color: Colors.blueAccent
        ),
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
              child: Obx( //                             ============================ 4 ================================
                () => Text(
                  "Nilai: ${counterController.count}",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: counterController.decrement,
                  child: Text("Decrement"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: counterController.increment,
                  child: Text("Increment"),
                ),
              ],
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Get.to(Profil()); // Ke halaman profil
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  "Flutter GetX",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}