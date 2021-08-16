import 'package:dio/dio.dart';
import '../config.dart';
import '../models/FaqChatBot/chatBot_Model.dart';


class WebServiceFaqApiInit {
  var dio = new Dio();

  Future<List<ChatModel>> fetchArticle() async {

    final response = await dio.get(AppConfig().faqInit);

    if(response.statusCode == 200){
      final result = response.data;
      Iterable list = result['Faq'];
      return list.map((messages) => ChatModel.fromJson(messages)).toList();
    } else {
      throw Exception('Unable to Connect');
    }
  }
}