import 'package:dio/dio.dart';
import 'package:my_news_app/const/string_constants.dart';
import 'package:my_news_app/featured/home/view/widget/news_model.dart';
import 'package:my_news_app/shared/api_client/dio_client_provider.dart';

class NewsService {
  final Dio _dio = Dio();

  Future<List<News>> fetchNews(String country) async {
    final response = await _dio.get(
      "${StringConstants.developmentBaseUrl}v2/top-headlines?country=${country.toLowerCase()}&apiKey=${StringConstants.apiKey}"
    );
    
    final List<dynamic>? data = response.data["articles"];
    talker.debug("Data : $data");
    if(data != null && data.isNotEmpty) {
      List<News> news = [];
      for(int i = 0; i < data.length; i++) {
        final element = data[i];
        news.add(
          News(
            source: element["source"]["name"] ?? "Source", 
            description: element["description"] ?? "Description", 
            imageUrl: element["urlToImage"] ?? "url", 
            timestamp: DateTime.now()
          ));
      }
      return news;
    }

    else {
      return [];
    }
  }
}