import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xnara/models/ChatBot/chatJsonModel.dart';
import '../models/ChatBot/chatMessageModel.dart';
import '../config.dart';
import '../models/ChatBot/chatInitModel.dart';

class WebServiceChatApi {
  var dio = new Dio();

  Future<ChatInitModel> faqInit() async {
    final response = await dio.post(AppConfig().faqInit);
    try {
      if (response.statusCode == 200) {
        final ChatInitModel _lists =
            chatInitModelFromJson(jsonEncode(response.data));
        return _lists;
      } else {
        throw Exception('Unable to Connect');
      }
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  Future<List<ChatJsonModel>> fetchMessageResponse(
      String message, String sessionId) async {

    var formData = FormData.fromMap({
      'message': message,
      'sessionId': sessionId,
    });

    final response = await dio.post(
      AppConfig().faqChat,
      data: formData,
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    try {
      if (response.statusCode == 200) {
        final result = response.data;
        Iterable list = result['messages'];
        return list.map((article) => chatJsonModelFromJson(article)).toList();
      } else {
        throw Exception('Unable to Connect');
      }
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
