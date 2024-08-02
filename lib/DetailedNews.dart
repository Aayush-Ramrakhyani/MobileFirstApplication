import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilefist_application/ArticleModel.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('By ${article.author}'), 
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Published at: ${_formatDate(article.publishedAt)}'),
            ),
            article.urlToImage != ''
                ? Image.network(article.urlToImage)
                : Container(),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.description,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.content, 
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _formatDate(String dateStr) {
    final DateTime dateTime = DateTime.parse(dateStr);
    final DateFormat formatter = DateFormat('hh:mm a zzz EEE dd MMM yyyy');
    return formatter.format(dateTime);
  }
}
