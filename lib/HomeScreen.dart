import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilefist_application/ArticleController.dart';
import 'package:mobilefist_application/ArticleModel.dart';
import 'package:mobilefist_application/DetailedNews.dart';

class HomePage extends StatelessWidget {
  final ArticleController articleController = Get.put(ArticleController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search news...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (query) {
                    if (query.isNotEmpty) {
                      articleController.searchArticles(query);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryTab(
                      title: 'Everything',
                      onTap: () => articleController.fetchArticlesByCategory('general'),
                    ),
                    CategoryTab(
                      title: 'Business',
                      onTap: () => articleController.fetchArticlesByCategory('business'),
                    ),
                    CategoryTab(
                      title: 'Entertainment',
                      onTap: () => articleController.fetchArticlesByCategory('entertainment'),
                    ),
                    CategoryTab(
                      title: 'Health',
                      onTap: () => articleController.fetchArticlesByCategory('health'),
                    ),
                    CategoryTab(
                      title: 'Science',
                      onTap: () => articleController.fetchArticlesByCategory('science'),
                    ),
                    CategoryTab(
                      title: 'Sports',
                      onTap: () => articleController.fetchArticlesByCategory('sports'),
                    ),
                    CategoryTab(
                      title: 'Technology',
                      onTap: () => articleController.fetchArticlesByCategory('technology'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (articleController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification &&
                scrollNotification.metrics.extentAfter == 0) {
              articleController.loadMoreArticles();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: articleController.articles.length + 1,
            itemBuilder: (context, index) {
              if (index == articleController.articles.length) {
                return articleController.isLoadingMore.value
                    ? Center(child: CircularProgressIndicator())
                    : Container();
              }
              return GestureDetector(
                onTap: () {
                  Get.to(NewsDetailScreen(article: articleController.articles[index]));
                },
                child: NewsCard(article: articleController.articles[index]),
              );
            },
          ),
        );
      }),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  CategoryTab({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Chip(
          label: Text(title),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final Article article;

  NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          article.urlToImage.isNotEmpty
              ? Image.network(article.urlToImage)
              : Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(article.description),
          ),
          
        ],
      ),
    );
  }
}
