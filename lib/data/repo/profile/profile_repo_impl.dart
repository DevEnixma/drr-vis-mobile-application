import 'package:wts_bloc/data/repo/profile/profile_repo.dart';

import '../../../utils/exceptions/exceptions.dart';
import '../../service/api/api_path.dart';
import '../../service/service.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future getProfile() async {
    try {
      final response = await apiService.get(path: ApiPath.getProfile);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch get profile');
    }
  }
}
