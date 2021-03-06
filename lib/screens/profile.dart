import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tetris/componets/foundation_button.dart';
import 'package:tetris/componets/left_menu.dart';
import 'package:tetris/controllers/user_controller.dart';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserController userController = Get.put(UserController());
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
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
                      buildInputField(
                          context,
                          "Ad Soyad",
                          Icons.person,
                          TextInputType.text,
                          userController.fullName.value, (value) {
                        userController.setFullName(value);
                      }),
                      buildInputField(
                          context,
                          "Kullanıcı Adınız",
                          Icons.emoji_people,
                          TextInputType.text,
                          userController.userName.value, (value) {
                        userController.setUserName(value);
                      }),
                      buildInputField(
                          context,
                          "E-posta adresiniz",
                          Icons.email,
                          TextInputType.emailAddress,
                          userController.email.value, (value) {
                        userController.setEmail(value);
                      }),
                      Obx(() {
                        if (userController.isAnyUser.value) {
                          return FoundationButton(
                              "Güncelle", () => _updateUser());
                        } else {
                          return FoundationButton(
                              "Kaydet", () => _validation());
                        }
                      }),
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

  Widget buildInputField(BuildContext context, String inputText, icon, type,
      String inputValue, textChange) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        keyboardType: type,
        controller: TextEditingController.fromValue(TextEditingValue(
            text: inputValue,
            selection: TextSelection.collapsed(offset: inputValue.length))),
        decoration: InputDecoration(
            labelText: inputText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            )),
        onChanged: textChange,
      ),
    );
  }

  _validation() async {
    if (userController.email.value == "" ||
        userController.userName.value == "" ||
        userController.fullName.value == "") {
      showToastMessage(
          "Lütfen profil bilgilerini eksiksiz giriniz", Colors.red);
    } else {
      String device = "";
      if (Platform.isAndroid) {
        // Android-specific code
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Running on ${androidInfo.brand}');
        device = '${androidInfo.brand} - ${androidInfo.model}';
      } else if (Platform.isIOS) {
        // iOS-specific code
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Running on ${iosInfo.utsname.machine}');
        device = iosInfo.utsname.machine.toString();
      }

      var isInsert = await userController.insertUser(device);
      if (isInsert?.status ?? false) {
        print("userId: " + isInsert!.userId.toString());
        userController.setMemoryUser(isInsert.userId);
        userController.getUserId();
        showToastMessage("Kaydetme işlemi başarıyla gerçekleşti", Colors.green);
      } else {
        showToastMessage("Kaydetme işlemi başarısız oldu.", Colors.red);
      }
    }
  }

  _updateUser() async {
    if (userController.email.value == "" ||
        userController.userName.value == "" ||
        userController.fullName.value == "") {
      showToastMessage(
          "Lütfen profil bilgilerini eksiksiz giriniz", Colors.red);
    } else {
      String device = "";
      if (Platform.isAndroid) {
        // Android-specific code
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Running on ${androidInfo.brand}');
        device = '${androidInfo.brand} - ${androidInfo.model}';
      } else if (Platform.isIOS) {
        // iOS-specific code
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Running on ${iosInfo.utsname.machine}');
        device = iosInfo.utsname.machine.toString();
      }

      var isUpdate = await userController.updateUser(device);
      if (isUpdate?.status ?? false) {
        print("userId: " + isUpdate!.userId.toString());

        userController.setMemoryUser(isUpdate.userId);
        showToastMessage(
            "Güncelleme işlemi başarıyla gerçekleşti", Colors.green);
      } else {
        showToastMessage("Güncelleme işlemi başarısız oldu.", Colors.red);
      }
    }
  }

  void showToastMessage(String message, Color toastColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
