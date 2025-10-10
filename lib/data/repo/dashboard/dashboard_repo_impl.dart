import '../../../utils/exceptions/exceptions.dart';
import '../../service/api/api_path.dart';
import '../../service/service.dart';
import 'dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  @override
  Future<dynamic> getTopVehicle(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getTopVehicle, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getTopVehicle');
    }
  }

  Future<dynamic> getCCTV() async {
    try {
      final response = await apiService.get(path: ApiPath.getCCTV);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getCCTV');
    }
  }

  Future<dynamic> getDailyWeighedSumVehicle(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getDailyWeighedSumVehicle, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getDailyWeighedSumVehicle');
    }
  }

  Future<dynamic> getVehicleWeightInspection(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getVehicleWeightInspection, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getVehicleWeightInspection');
    }
  }

  Future<dynamic> getDashboardViewSumPlanChart(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getDashboardViewSumPlanChart, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch getDashboardViewSumPlanChart');
    }
  }

  @override
  Future getTopFiveRoad(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getTopFiveRoad, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch get Top Five Road');
    }
  }

  @override
  Future getRoadCodeDetail(String roadCode) async {
    try {
      final response = await apiService.get(path: ApiPath.getRoadCodeDetail(roadCode));
      return response;
    } catch (e) {
      throw RepoException('Error wile catch get Road Code Detail');
    }
  }

  @override
  Future getRoadCodeCar(Map<String, dynamic>? query) async {
    try {
      final response = await apiService.get(path: ApiPath.getRoadCodeCar, query: query);
      return response;
    } catch (e) {
      throw RepoException('Error wile catch get Road Code Car');
    }
  }
}
