class ApiPath {
  ApiPath._();

  // Auth
  static const String postLogin = '/auth/token';
  static const String getProfile = '/auth/me';

  // Test/Demo (ถ้ายังใช้ ProductRepo)
  static const String getAllProducts = '/products';

  // Dashboard
  static const String getTopVehicle = '/dashboards/way_traffic/top_vehicle';
  static const String getCCTV = '/dashboards/cctv';
  static const String getDailyWeighedSumVehicle =
      '/dashboards/daily_weighed_vehicles_sum';
  static const String getVehicleWeightInspection =
      '/dashboards/vehicle_weight_inspection';
  static const String getDashboardViewSumPlanChart =
      '/dashboards/view_sum_plan_chart';

  // Weight
  static const String getMobileMaster = '/weight/mobile_master';
  static const String getMobileCar = '/weight/weight_mobile_car';
  static const String postUnitWeight = '/weight/weight_mobile_master';
  static const String postWeightAddCar = '/weight/weight_mobile_master_detail';
  static const String putWeightAddCar = '/weight/weight_mobile_master_detail';
  static const String postJoinUnitWeight = '/weight/weight_mobile_master/join';

  static String getMobileCarDetail(String tdId) =>
      '/weight/weight_mobile_car/$tdId';
  static String getMobileMasterDepartment(String tid) =>
      '/weight/weight_mobile_master_department/$tid';
  static String postUnitWeightImage(String unitID) =>
      '/weight/weight_mobile_master/$unitID/photo';
  static String postWeightAddCarImage(String tId, String tdId) =>
      '/weight/weight_mobile_master_detail/photo/$tId/$tdId';
  static String getWeightAddCarImage(String tId, String tdId) =>
      '/weight/weight_mobile_master_detail/photo/$tId/$tdId';
  static String deleteJoinUnitWeight(String tId, String username) =>
      '/weight/weight_mobile_master/join/$tId/$username';
  static String postCloseWeightUnit(String tId) =>
      '/weight/weight_mobile_master/$tId/close';

  // Info
  static const String getInfoWeightArretSport = '/info/weight_arrest/spot';
  static const String getTopFiveRoad = '/info/current_vehicle_status/itemsSum';
  static const String getRoadCodeCar = '/info/current_vehicle_status';

  // Masters
  static const String getCollaborative = '/masters/collaborative_list';
  static const String getWays = '/masters/way_all';
  static const String getMasterVehicleClass = '/masters/vehicle_class';
  static const String getMasterProvince = '/masters/province_plates';
  static const String getMaterail = '/masters/goods';
  static const String getProvinceMaster = '/masters/provinces';
  static const String getDistrctsMaster = '/masters/districts';
  static const String getSubDistrctsMaster = '/masters/subdistricts';

  static String getWayID(String wayID) => '/masters/way/$wayID';
  static String getRoadCodeDetail(String roadCode) =>
      '/masters/roads/road_code/$roadCode';

  // Reports
  static const String getReportArrest = '/reports/arrest';

  // News
  static const String getNews = '/news';
  static String getNewsDetail(String newsId) => '/news/$newsId';

  // Arrest
  static const String postArrestLogs = '/arrest_record';
  static String getArrestLogs(String tdId) => '/arrest_record/$tdId';
  static String putArrestLogs(String tdId) => '/arrest_record/$tdId';
  static String getArrestLogsPdf(String arrestId) =>
      '/arrest_record/$arrestId/export_pdf';
}
