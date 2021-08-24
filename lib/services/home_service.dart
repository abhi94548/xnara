import 'package:dio/dio.dart';
import '../config.dart';

class WebServiceFoodApi {
  Dio dio = Dio();

  Future<Map<String, dynamic>> fetchFoodList() async {
    try {
      final Response<dynamic> response = await dio.get(
        AppConfig().foodApiList,
        options: Options(
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        final dynamic reply = response.data;
        final Map<String, dynamic> _lists = reply as Map<String, dynamic>;
        return _lists;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
