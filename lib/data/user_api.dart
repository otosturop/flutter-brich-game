import 'package:dio/dio.dart';
import 'package:tetris/models/UserModel.dart';
import 'package:tetris/models/UsersScoreModel.dart';

class UserApi {
  static const _url = "http://tetrisapi.massviptransfer.com/";

  late Dio _dio;

  UserApi() {
    _dio = Dio();
  }

  Future<UserModel?> fetchUsers() async {
    try {
      Response response = await _dio.get(_url);
      UserModel usersResponse = UserModel.fromJson(response.data);
      return usersResponse;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<UserModel?> insertUser(
      String fullName, String email, String userName) async {
    try {
      var formData = FormData.fromMap({
        'full_name': fullName,
        'email': email,
        'username': userName,
      });
      var response =
          await _dio.post(_url + 'users/insert_user', data: formData);
      UserModel usersResponse = UserModel.fromJson(response.data);
      return usersResponse;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<UsersScoreModel?> fetchUsersScore() async {
    try {
      var response = await _dio.post(_url + 'tetris/get_users_score');
      UsersScoreModel usersScore = UsersScoreModel.fromJson(response.data);
      return usersScore;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
