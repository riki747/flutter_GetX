import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          //  gambar oval
          InkWell(
            onTap: ()  {
              controller.goToProfil();
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: AssetImage("images/profil.png"),
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('HomeView ', style: TextStyle(fontSize: 20)),
            // isi dashboard
            Text('Selamat datang di Dashboard', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
