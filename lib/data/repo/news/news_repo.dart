abstract class NewsRepo {
  Future<dynamic> getNews(Map<String, dynamic>? query);
  Future<dynamic> getNewsDetail(String newsId);
}
