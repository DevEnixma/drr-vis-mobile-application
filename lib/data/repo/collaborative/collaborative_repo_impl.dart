import 'package:wts_bloc/data/repo/collaborative/collaborative_repo.dart';

import '../../../utils/exceptions/exceptions.dart';
import '../../service/api/api_path.dart';
import '../../service/service.dart';

class CollaborativeRepoImpl implements CollaborativeRepo {
  @override
  Future getCollaborative(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getCollaborative, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getCollaborative');
    }
  }
}
