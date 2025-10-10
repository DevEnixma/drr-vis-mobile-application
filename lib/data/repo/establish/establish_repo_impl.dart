import 'package:wts_bloc/data/repo/establish/establish_repo.dart';

import '../../../utils/exceptions/exceptions.dart';
import '../../service/api/api_path.dart';
import '../../service/service.dart';

class EstablishRepoImpl implements EstablishRepo {
  @override
  Future<dynamic> getMobileMaster(Map<String, dynamic>? query) async {
    try {
      print("XXX: ${query}");
      final response = await apiService.get(path: ApiPath.getMobileMaster, query: query);
      print("XXX: ${response.statusCode}");
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getMobileMaster');
    }
  }

  @override
  Future<dynamic> getMobileMasterDepartment({String? tid}) async {
    try {
      final response = await apiService.get(path: ApiPath.getMobileMasterDepartment(tid ?? ''));
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getMobileMasterDepartment');
    }
  }

  @override
  Future<dynamic> getMobileCar(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getMobileCar, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getMobileCar');
    }
  }

  @override
  Future getMobileCarDetail(String tdId) async {
    try {
      final response = await apiService.get(path: ApiPath.getMobileCarDetail(tdId));
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getMobileCarDetail');
    }
  }

  @override
  Future postUnitWeight(String body) async {
    try {
      final response = await apiService.post(path: ApiPath.postUnitWeight, body: body);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postUnitWeight');
    }
  }

  @override
  Future postUnitWeightImage(String unitID, file1, file2) async {
    try {
      final response = await apiService.createUnitImage(path: ApiPath.postUnitWeightImage(unitID), filePath1: file1, filePath2: file2);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postUnitWeightImage');
    }
  }

  @override
  Future postAddCarUnitWeight(String body) async {
    try {
      final response = await apiService.post(path: ApiPath.postWeightAddCar, body: body);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postWeightAddCar');
    }
  }

  @override
  Future putAddCarUnitWeight(String body) async {
    try {
      final response = await apiService.put(path: ApiPath.putWeightAddCar, body: body);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch putWeightAddCar');
    }
  }

  @override
  Future postAddCarUnitWeigntImage(String tId, tdId, image_path1, image_path2, image_path3, image_path4, image_path5, image_path6) async {
    try {
      final response = await apiService.createCarImage(path: ApiPath.postWeightAddCarImage(tId, tdId), image_path1: image_path1 ?? '', image_path2: image_path2 ?? '', image_path3: image_path3 ?? '', image_path4: image_path4 ?? '', image_path5: image_path5 ?? '', image_path6: image_path6 ?? '');
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postWeightAddCarImage');
    }
  }

  @override
  Future getImageCar(String tId, tdId) async {
    try {
      final response = await apiService.get(path: ApiPath.getWeightAddCarImage(tId, tdId));
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getWeightAddCarImage');
    }
  }

  @override
  Future postJoinWeightUnit(String body) async {
    try {
      final response = await apiService.post(path: ApiPath.postJoinUnitWeight, body: body);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postJoinUnitWeight');
    }
  }

  @override
  Future deleteJoinWeightUnit(String tId, username) async {
    try {
      final response = await apiService.delete(path: ApiPath.deleteJoinUnitWeight(tId, username));
      return response;
    } catch (e) {
      throw RepoException('Error wile catch deleteJoinUnitWeight');
    }
  }

  @override
  Future postCloseWeightUnit(String tId) async {
    try {
      final response = await apiService.post(path: ApiPath.postCloseWeightUnit(tId));
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postCloseUnitWeight');
    }
  }
}
