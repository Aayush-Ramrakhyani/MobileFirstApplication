import 'package:get/get.dart';
import 'package:mobilefist_application/APIService.dart';
import 'package:mobilefist_application/ArticleModel.dart';

class ArticleController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var currentPage = 1;
  var searchQuery = ''.obs;
  var selectedCategory = 'general'.obs; 

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    isLoading(true);
    try {
      var fetchedArticles = await ApiService().fetchArticles(currentPage);
      articles.value = fetchedArticles;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchArticlesByCategory(String category) async {
    isLoading(true);
    selectedCategory.value = category;
    currentPage = 1;
    try {
      var fetchedArticles = await ApiService().fetchArticlesByCategory(category, currentPage);
      articles.value = fetchedArticles;
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchArticles(String query) async {
    isLoading(true);
    searchQuery.value = query;
    currentPage = 1;
    try {
      var searchedArticles = await ApiService().searchArticles(query, currentPage);
      articles.value = searchedArticles;
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreArticles() async {
    if (isLoadingMore.value) return;
    isLoadingMore(true);
    currentPage++;
    try {
      List<Article> moreArticles;
      if (searchQuery.value.isNotEmpty) {
        moreArticles = await ApiService().searchArticles(searchQuery.value, currentPage);
      } else if (selectedCategory.value != 'general') {
        moreArticles = await ApiService().fetchArticlesByCategory(selectedCategory.value, currentPage);
      } else {
        moreArticles = await ApiService().fetchArticles(currentPage);
      }
      if (moreArticles.isNotEmpty) {
        articles.addAll(moreArticles);
      }
    } finally {
      isLoadingMore(false);
    }
  }
}
