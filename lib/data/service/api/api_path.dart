class ApiPath {
  static const String postLogin = '/auth/token';
  static const String getProfile = '/auth/me';
  // static const String postRefreshToken = '';

  static const String getTopVehicle = '/dashboards/way_traffic/top_vehicle';

  static const String getCCTV = '/dashboards/cctv';

  static const String getDailyWeighedSumVehicle = '/dashboards/daily_weighed_vehicles_sum';

  static const String getVehicleWeightInspection = '/dashboards/vehicle_weight_inspection';

  static const String getDashboardViewSumPlanChart = '/dashboards/view_sum_plan_chart';

  static const String getMobileMaster = '/weight/mobile_master';

  static const String getMobileCar = '/weight/weight_mobile_car';

  static String getMobileCarDetail(String tdId) {
    return '/weight/weight_mobile_car/${tdId}';
  }

  static const String getInfoWeightArretSport = '/info/weight_arrest/spot';

  static String getMobileMasterDepartment(String tid) {
    return '/weight/weight_mobile_master_department/$tid';
  }

  // test
  static const String getAllProducts = 'products';
  static const String LOGIN_PATH = "/user/pre_login";

  static const String getCollaborative = '/masters/collaborative_list';
  static const String getWays = '/masters/way_all';
  static String getWayID(String wayID) {
    return '/masters/way/${wayID}';
  }

  static const String postUnitWeight = '/weight/weight_mobile_master';

  static String postUnitWeightImage(unitID) {
    return '/weight/weight_mobile_master/${unitID}/photo';
  }

  static String getMasterVehicleClass = '/masters/vehicle_class';
  static String getMasterProvince = '/masters/province_plates';

  static String getReportArrest = '/reports/arrest';
  static String getMaterail = '/masters/goods';

  static String postWeightAddCar = '/weight/weight_mobile_master_detail';
  static String putWeightAddCar = '/weight/weight_mobile_master_detail';

  static String postWeightAddCarImage(tId, tdId) {
    return '/weight/weight_mobile_master_detail/photo/${tId}/${tdId}';
  }

  static String getWeightAddCarImage(tId, tdId) {
    return '/weight/weight_mobile_master_detail/photo/${tId}/${tdId}';
  }

  static String getNews = '/news';
  static String getNewsDetail(newsId) {
    return '/news/${newsId}';
  }

  static const String postArrestLogs = '/arrest_record';
  static String getArrestLogs(String td_id) {
    return '/arrest_record/$td_id';
  }

  static String putArrestLogs(String td_id) {
    return '/arrest_record/$td_id';
  }

  static const String getProvinceMaster = '/masters/provinces';
  static const String getDistrctsMaster = '/masters/districts';
  static const String getSubDistrctsMaster = '/masters/subdistricts';

  static const String postJoinUnitWeight = '/weight/weight_mobile_master/join';
  static String deleteJoinUnitWeight(String tId, username) {
    return '/weight/weight_mobile_master/join/${tId}/${username}';
  }

  static String postCloseWeightUnit(String tId) {
    return '/weight/weight_mobile_master/${tId}/close';
  }

  static const String getTopFiveRoad = '/info/current_vehicle_status/itemsSum';

  static String getRoadCodeDetail(String roadCode) {
    return '/masters/roads/road_code/${roadCode}';
  }

  static const String getRoadCodeCar = '/info/current_vehicle_status';
}
