abstract class EstablishRepo {
  Future<dynamic> getMobileMaster(Map<String, dynamic>? query);
  Future<dynamic> getMobileMasterDepartment({String? tid});
  Future<dynamic> getMobileCar(Map<String, dynamic>? query);
  Future<dynamic> getMobileCarDetail(String tdId);
  Future<dynamic> postUnitWeight(String body);
  Future<dynamic> postUnitWeightImage(String unitI, file1, file2);
  Future<dynamic> postAddCarUnitWeight(String body);
  Future<dynamic> postAddCarUnitWeigntImage(String tId, tdId, iimage_path1, image_path2, image_path3, image_path4, image_path5, image_path6);
  Future<dynamic> getImageCar(String tId, tdId);
  Future<dynamic> postJoinWeightUnit(String body);
  Future<dynamic> deleteJoinWeightUnit(String tId, username);
  Future<dynamic> postCloseWeightUnit(String tId);
  Future<dynamic> putAddCarUnitWeight(String body);
}
