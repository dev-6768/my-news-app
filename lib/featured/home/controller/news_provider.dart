  import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/featured/home/controller/country_provider.dart';
import 'package:my_news_app/featured/home/view/widget/news_model.dart';
import 'package:my_news_app/shared/api_client/dio_news_service_client.dart';

final newsProvider = FutureProvider<List<News>>((ref) async {
  final country = ref.watch(countryProvider);
  final newsService = NewsService();
  return newsService.fetchNews(country);
});