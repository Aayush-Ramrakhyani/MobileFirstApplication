import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilefist_application/ArticleModel.dart';

class ApiService {
  final String apiKey = '6c86ce37b9104a049d3becdfb6888082';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchArticles(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/everything?q=keyword&apiKey=$apiKey&page=$page'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<List<Article>> fetchArticlesByCategory(String category, int page) async {
    final response = await http.get(Uri.parse('$baseUrl/top-headlines?country=in&category=$category&apiKey=$apiKey&page=$page'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<List<Article>> searchArticles(String query, int page) async {
    final response = await http.get(Uri.parse('$baseUrl/everything?q=$query&apiKey=$apiKey&page=$page'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
