import 'package:dio/dio.dart';
import 'package:tetris/models/TetrisModel.dart';

class TetrisApi {
  static const _url = "http://tetrisapi.massviptransfer.com/tetris/";

  late Dio _dio;

  TetrisApi() {
    _dio = Dio();
  }

  Future<TetrisModel?> fetchUsersTetrisPoint() async {
    try {
      Response response = await _dio.get(_url);
      TetrisModel tetrisResponse = TetrisModel.fromJson(response.data);
      return tetrisResponse;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<TetrisModel?> updateTetrisPoint(String userId, String topScore) async {
    try {
      var formData = FormData.fromMap({
        'top_score': topScore,
        'user_id': userId,
      });
      var response = await _dio.post(_url + 'update_score', data: formData);
      TetrisModel pointResponse = TetrisModel.fromJson(response.data);
      return pointResponse;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
