import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tetris/componets/left_menu.dart';
import 'package:tetris/controllers/timer_controller.dart';
import 'package:tetris/controllers/user_controller.dart';

class Home extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final TimerController timerController = Get.put(TimerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: new BoxDecoration(color: Colors.black12),
                  child: LeftMenu(),
                )),
            Expanded(
              flex: 2,
              child: Container(
                decoration: new BoxDecoration(color: Colors.white10),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Tetris Şampiyonasına Hoşgeldiniz",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                        homeCard(
                            Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.black,
                            ),
                            'Adı Soyadı',
                            userController.isAnyUser.value
                                ? userController.fullName.value.toString()
                                : 'Bulunamadı'),
                        homeCard(
                            Icon(Icons.emoji_people,
                                size: 30, color: Colors.black),
                            'Kullanıcı Adı',
                            userController.isAnyUser.value
                                ? userController.userName.value.toString()
                                : 'Bulunamadı'),
                        Obx(() {
                          if (userController.isLoading.value) {
                            return homeCard(
                                Icon(Icons.emoji_events,
                                    size: 30, color: Colors.black),
                                'Sıralamam',
                                userController.userArrangement.value);
                          } else {
                            return homeCard(
                                Icon(Icons.emoji_events,
                                    size: 30, color: Colors.black),
                                'Sıralamam',
                                'Bulunamadı');
                          }
                        }),
                        homeCard(
                            Icon(Icons.emoji_events,
                                size: 30, color: Colors.black),
                            'En Yüksek Skor',
                            userController.isAnyUser.value
                                ? userController.score.value.toString()
                                : '0'),
                        gameRightCard(),
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding homeCard(Icon icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: icon,
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding gameRightCard() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 4,
        child: Column(
          children: [
            Obx(() {
              return ListTile(
                leading: Icon(
                  Icons.volunteer_activism,
                  size: 30,
                  color: Colors.black,
                ),
                title: timerController.countDown(),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var x = 0; x < timerController.right.value; x++)
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                        size: 18,
                      ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
