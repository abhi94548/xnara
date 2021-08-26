import 'dart:convert';

import 'package:dio/dio.dart';

import '../config.dart';
import '../helper/error_handler.dart';
import '../helper/http_service.dart';
import '../models/ChatBot/chat_init_model.dart';
import '../models/ChatBot/chat_json_model.dart';

class WebServiceChatApi {
  final HttpService httpService = HttpService();

  Future<ChatInitModel> faqInit() async {
    try {
      final Response<dynamic> response =
          await httpService.requestSource(AppConfig().faqInit, 'POST');
      return chatInitModelFromJson(jsonEncode(response.data));
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else if (error.type == DioErrorType.other) {
        throw ShowError('No Internet connection...');
      } else {
        throw ShowError('Something went wrong');
      }
    }
  }

  Future<List<ChatJsonModel>> fetchMessageResponse(
      String message, String sessionId) async {
    final Map<String, String> map = <String, String>{
      'message': message,
      'sessionId': sessionId,
    };

    try {
      final Response<dynamic> response = await httpService
          .requestSource(AppConfig().faqChat, 'POST', data: map);
      final Iterable<dynamic> _list =
          response.data['messages'] as Iterable<dynamic>;
      return chatJsonModelFromJson(jsonEncode(_list));
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else if (error.type == DioErrorType.other) {
        throw ShowError('No Internet connection...');
      } else {
        throw ShowError('Something went wrong');
      }
    }
  }
}
