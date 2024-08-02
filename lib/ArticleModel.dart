class Article {
  final String title;
  final String author;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String content;

  Article({
    required this.title,
    required this.author,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] as String? ?? 'No Title',
      author: json['author'] as String? ?? 'No Author',
      description: json['description'] as String? ?? 'No Description',
      urlToImage: json['urlToImage'] as String? ?? '',
      url: json['url'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
      content: json['content'] as String? ?? 'No Content',
    );
  }
}
