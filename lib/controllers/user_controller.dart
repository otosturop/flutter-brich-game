import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris/controllers/tetris_controller.dart';
import 'package:tetris/data/user_api.dart';
import 'package:tetris/models/UserModel.dart';

class UserController extends GetxController {
  var fullName = ''.obs;
  var userId = ''.obs;
  var userName = ''.obs;
  var email = ''.obs;
  var score = 0.obs;
  var loadingInfo = false.obs;
  var isAnyUser = false.obs;
  UserApi _userApi = UserApi();
  final TetrisController tetrisController = Get.put(TetrisController());

  Future getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userId')) {
      isAnyUser.value = false;
    } else {
      isAnyUser.value = true;
      userId.value = prefs.getString('userId')!;
      fullName.value = prefs.getString('fullName')!;
      userName.value = prefs.getString('userName')!;
      email.value = prefs.getString('email')!;
      score.value = prefs.getInt('score')!;
    }
  }

  @override
  void onInit() async {
    getUserId();
    super.onInit();
  }

  void setFullName(value) => fullName.value = value;

  void setUserName(value) => userName.value = value;

  void setEmail(value) => email.value = value;

  Future<UserModel?> insertUser() async {
    UserModel? stat =
        await _userApi.insertUser(fullName.value, email.value, userName.value);
    return stat;
  }

  void setMemoryUser(userId) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('userId', userId.toString());
    pre.setString('fullName', fullName.value.toString());
    pre.setString('userName', userName.value.toString());
    pre.setString('email', email.value.toString());
    pre.setInt('score', 0);
    tetrisController.onInit();
  }
}
