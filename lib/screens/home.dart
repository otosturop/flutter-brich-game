import 'package:flutter/material.dart';
import 'package:tetris/componets/left_menu.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
                  child: Column(
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
                          'Bulunamadı'),
                      homeCard(
                          Icon(Icons.emoji_people,
                              size: 30, color: Colors.black),
                          'Kullanıcı Adı',
                          'Bulunamadı'),
                      homeCard(
                          Icon(Icons.emoji_events,
                              size: 30, color: Colors.black),
                          'Sıralamam',
                          '**'),
                      gameRightCard(),
                    ],
                  ),
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
            ListTile(
              leading: Icon(
                Icons.volunteer_activism,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                '02:46:58',
                textAlign: TextAlign.center,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                    size: 18,
                  ),
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                    size: 18,
                  ),
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
