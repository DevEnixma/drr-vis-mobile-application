abstract class DashboardRepo {
  Future<dynamic> getTopVehicle(Map<String, dynamic>? query);
  Future<dynamic> getCCTV();
  Future<dynamic> getDailyWeighedSumVehicle(Map<String, dynamic>? query);
  Future<dynamic> getVehicleWeightInspection(Map<String, dynamic>? query);
  Future<dynamic> getDashboardViewSumPlanChart(Map<String, dynamic>? query);
  Future<dynamic> getTopFiveRoad(Map<String, dynamic>? query);
  Future<dynamic> getRoadCodeDetail(String roadCode);
  Future<dynamic> getRoadCodeCar(Map<String, dynamic>? query);
}
