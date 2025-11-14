import 'package:flutter/foundation.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

enum NewsStatus { initial, loading, loaded, error }

class NewsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<ArticleModel> _articles = [];
  NewsStatus _status = NewsStatus.initial;
  String _errorMessage = '';

  List<ArticleModel> get articles => _articles;
  NewsStatus get status => _status;
  String get errorMessage => _errorMessage;

  Future<void> fetchTopHeadlines() async {
    if (_status == NewsStatus.initial) {
      _status = NewsStatus.loading;
      notifyListeners();

      try {
        _articles = await _apiService.getTopHeadlines();
        _status = NewsStatus.loaded;
      } catch (e) {
        _errorMessage = e.toString();
        _status = NewsStatus.error;
      }
      notifyListeners();
    }
  }
}