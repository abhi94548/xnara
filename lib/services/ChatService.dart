import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/ChatBot/chatJsonModel.dart';
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


    Map map = {
      "message": message,
      "sessionId": sessionId,
    };

    final response = await dio.post(
      AppConfig().faqChat,
      data: map,
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    try {
      if (response.statusCode == 200) {
        final result = response.data;
        Iterable _list = result['messages'];
        final List<ChatJsonModel> lists = chatJsonModelFromJson(jsonEncode(_list));
        print(lists.toString());
        return lists;
      } else {
        throw Exception('Unable to Connect');
      }
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
