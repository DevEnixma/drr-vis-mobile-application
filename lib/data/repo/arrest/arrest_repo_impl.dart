import 'package:wts_bloc/data/repo/arrest/arrest_repo.dart';

import '../../../utils/exceptions/exceptions.dart';
import '../../service/api/api_path.dart';
import '../../service/service.dart';

class ArrestRepoImpl implements ArrestRepo {
  @override
  Future getInfoWeightArretSport(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getInfoWeightArretSport, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getMobileMaster');
    }
  }

  @override
  Future getReportArrest(String tdId, Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getReportArrest, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getReportArrest');
    }
  }

  @override
  Future postArrestLogs(String body) async {
    try {
      final response = await apiService.post(path: ApiPath.postArrestLogs, body: body);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postArrestLogs');
    }
  }

  @override
  Future putArrestLogs(String tdId, body) async {
    try {
      final response = await apiService.put(path: ApiPath.putArrestLogs(tdId), body: body);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postArrestLogs');
    }
  }

  @override
  Future getArrestLogsShow(String arrestId) async {
    try {
      final response = await apiService.get(path: ApiPath.getArrestLogs(arrestId));
      return response;
    } catch (e) {
      throw RepoException('Error wile catch postArrestLogs');
    }
  }
}
