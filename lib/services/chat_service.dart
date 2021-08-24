import 'dart:convert';

import 'package:dio/dio.dart';

import '../config.dart';
import '../models/ChatBot/chat_init_model.dart';
import '../models/ChatBot/chat_json_model.dart';

class WebServiceChatApi {
  Dio dio = Dio();

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


    final Map<String,String> map = {
      'message': message,
      'sessionId': sessionId,
    };

    final Response<dynamic> response = await dio.post(
      AppConfig().faqChat,
      data: map,
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    try {
      if (response.statusCode == 200) {
        final result = response.data;
        final Iterable<dynamic> _list = result['messages'] as Iterable<dynamic>;
        final List<ChatJsonModel> lists = chatJsonModelFromJson(jsonEncode(_list));
        return lists;
      } else {
        throw Exception('Unable to Connect');
      }
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
