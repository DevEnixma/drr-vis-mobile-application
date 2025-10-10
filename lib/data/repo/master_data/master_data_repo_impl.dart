import '../../../utils/exceptions/exceptions.dart';
import '../../service/api/api_path.dart';
import '../../service/service.dart';
import 'master_data_repo.dart';

class MasterDataRepoImpl implements MasterDataRepo {
  @override
  Future getWays(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getWays, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getWays');
    }
  }

  @override
  Future getWaysDetail(String wayID, Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getWayID(wayID), query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getWaysDetail');
    }
  }

  @override
  Future getMasterVehicleClass(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getMasterVehicleClass, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getMasterVehicleClass');
    }
  }

  @override
  Future getMasterProvince(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getMasterProvince, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getMasterProvince');
    }
  }

  @override
  Future getMaterial(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getMaterail, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getMaterail');
    }
  }

  @override
  Future getImage(String urlImage) async {
    try {
      final response = await apiService.getImageUrl(path: urlImage);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getImageUrl');
    }
  }

  @override
  Future getProvinceMasterData(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getProvinceMaster, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getProvinceMaster');
    }
  }

  @override
  Future getDistrctsMasterData(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getDistrctsMaster, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getDistrctsMaster');
    }
  }

  @override
  Future getSubDistrctsMasterData(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getSubDistrctsMaster, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getSubDistrctsMaster');
    }
  }
}
