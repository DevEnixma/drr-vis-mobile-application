abstract class MasterDataRepo {
  Future<dynamic> getWays(Map<String, dynamic>? query);
  Future<dynamic> getWaysDetail(String wayID, Map<String, dynamic>? query);
  // getMasterVehicleClass
  Future<dynamic> getMasterVehicleClass(Map<String, dynamic>? query);
  // get province
  Future<dynamic> getMasterProvince(Map<String, dynamic>? query);
  // get material
  Future<dynamic> getMaterial(Map<String, dynamic>? query);

  // Get Image
  Future<dynamic> getImage(String urlImage);
  // Get Image
  Future<dynamic> getProvinceMasterData(Map<String, dynamic>? query);
  Future<dynamic> getDistrctsMasterData(Map<String, dynamic>? query);
  Future<dynamic> getSubDistrctsMasterData(Map<String, dynamic>? query);
}
