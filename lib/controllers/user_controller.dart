import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris/data/user_api.dart';
import 'package:tetris/models/UserModel.dart';

class UserController extends GetxController {
  var fullName = ''.obs;
  var userName = ''.obs;
  var email = ''.obs;
  var loadingInfo = false.obs;
  var isLogin = true.obs;
  UserApi _userApi = UserApi();

  Future getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      isLogin.value = false;
    } else {
      isLogin.value = true;
      update();
      // String userId = prefs.getString('userId');
      // return userId;
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }

  void setFullName(value) => fullName.value = value;

  void setUserName(value) => userName.value = value;

  void setEmail(value) => email.value = value;

  Future<UserModel?> insertUser() async {
    UserModel? stat =
        await _userApi.insertUser(fullName.value, email.value, userName.value);
    return  stat;
  }
}
