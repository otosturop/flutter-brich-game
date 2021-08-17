import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tetris/controllers/user_controller.dart';

class Arragement extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sıralamalar'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Obx(() {
          if (userController.isLoading.value) {
            return ListView(
              children: [
                for (var i = 0; i < userController.usersScore.length; i++)
                  arragementCard(
                      (i + 1).toString(),
                      userController.usersScore[i].fullName!,
                      userController.usersScore[i].topScore!),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }

  Padding arragementCard(String number, String title, String description) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: Text(
                number,
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              trailing: Text(
                "puan: " + description,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
