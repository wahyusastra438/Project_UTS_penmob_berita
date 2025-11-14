import 'package:dio/dio.dart';
import '../models/article_model.dart';

class ApiService {
  final Dio _dio = Dio();
  
  final String _apiToken = 'a183bbdb28b73a13df1bdaaba97d5743'; 
  final String _baseUrl = 'https://gnews.io/api/v4/';

  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      final String endpoint = 'top-headlines?lang=id&token=$_apiToken';
      
      final response = await _dio.get(_baseUrl + endpoint);

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data['articles'];
        
        return articlesJson
            .map((json) => ArticleModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Gagal memuat berita');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  
}