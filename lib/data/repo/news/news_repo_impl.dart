import 'package:wts_bloc/data/repo/news/news_repo.dart';

import '../../../utils/exceptions/exceptions.dart';
import '../../service/api/api_path.dart';
import '../../service/service.dart';

class NewsRepoImpl implements NewsRepo {
  @override
  Future getNews(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getNews, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getNews');
    }
  }

  @override
  Future getNewsDetail(String newsId) async {
    try {
      final response = await apiService.get(path: ApiPath.getNewsDetail(newsId));
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getNewsDetail');
    }
  }
}
