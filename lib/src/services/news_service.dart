import 'package:flutter/material.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final urlNews = 'https://newsapi.org/v2';
final apiKey = '0bc2095cfe1341bdbeadb0e3ce794e18';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(Icons.build, 'business', 'Economía'),
    Category(Icons.cabin, 'entertainment', 'Espectáculos'),
    Category(Icons.description, 'general', 'General'),
    Category(Icons.earbuds, 'health', 'Salud'),
    Category(Icons.face, 'science', 'Ciencia'),
    Category(Icons.gamepad, 'sports', 'Deportes'),
    Category(Icons.hail, 'technology', 'Tecnología'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((category) {
      this.categoryArticles[category.name] = [];
    });
    this.getTopHeadlinesByCategory();
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String category) {
    this._selectedCategory = category;
    getTopHeadlinesByCategory();
    notifyListeners();
  }

  getTopHeadlines() async {
    final url = Uri.parse('$urlNews/top-headlines?apiKey=$apiKey&country=ar');
    final resp = await http.get(url);
    final newsResp = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResp.articles);
    notifyListeners();
  }

  getTopHeadlinesByCategory() async {
    if (this.categoryArticles[_selectedCategory]!.length > 0) {
      return this.categoryArticles[_selectedCategory];
    }

    final url = Uri.parse(
        '$urlNews/top-headlines?apiKey=$apiKey&country=ar&category=$_selectedCategory');
    final resp = await http.get(url);
    final newsResp = newsResponseFromJson(resp.body);
    this.categoryArticles[_selectedCategory]?.addAll(newsResp.articles);
    notifyListeners();
  }
}
