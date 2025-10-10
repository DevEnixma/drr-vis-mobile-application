import '../../../utils/exceptions/exceptions.dart';
import '../../service/api/api_path.dart';
import '../../service/service.dart';
import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  @override
  Future<dynamic> postLogin(String? body) async {
    try {
      final response = await apiService.post(path: ApiPath.postLogin, body: body);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch post login');
    }
  }

  // @override
  // Future<dynamic> postRefreshToken(String? body) async {
  //   try {
  //     final response = await apiService.post(path: ApiPath.postRefreshToken, body: body);
  //     return response;
  //   } catch (e) {
  //     throw RepoException('Error wile catch post Refresh Token');
  //   }
  // }
}
