class MobileMasterDepartmentModel {
  String? tid;
  int? deptId;
  String? deptProvince;
  String? wayId;
  String? wayName;
  String? subDistrict;
  String? district;
  String? province;
  String? kmFrom;
  String? kmTo;
  String? createDate;
  String? createBy;
  String? timeFrom;
  String? timeTo;
  String? latitude;
  String? longitude;
  String? collaboration;
  int? isOpen;
  String? total;
  String? totalOver;
  String? imagePath1;
  String? imagePath2;
  String? imageName1;
  String? imageName2;
  String? firstName;
  String? lastName;

  MobileMasterDepartmentModel.empty();

  MobileMasterDepartmentModel({
    this.tid,
    this.deptId,
    this.deptProvince,
    this.wayId,
    this.wayName,
    this.subDistrict,
    this.district,
    this.province,
    this.kmFrom,
    this.kmTo,
    this.createDate,
    this.createBy,
    this.timeFrom,
    this.timeTo,
    this.latitude,
    this.longitude,
    this.collaboration,
    this.isOpen,
    this.total,
    this.totalOver,
    this.imagePath1,
    this.imagePath2,
    this.imageName1,
    this.imageName2,
    this.firstName,
    this.lastName,
  });

  MobileMasterDepartmentModel.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    deptId = json['dept_id'];
    deptProvince = json['dept_province'];
    wayId = json['way_id'];
    wayName = json['way_name'];
    subDistrict = json['sub_district'];
    district = json['district'];
    province = json['province'];
    kmFrom = json['km_from'];
    kmTo = json['km_to'];
    createDate = json['create_date'];
    createBy = json['create_by'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    collaboration = json['collaboration'];
    isOpen = json['is_open'];
    total = json['Total'];
    totalOver = json['TotalOver'];
    imagePath1 = json['image_path1'];
    imagePath2 = json['image_path2'];
    imageName1 = json['image_name1'];
    imageName2 = json['image_name2'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['dept_id'] = this.deptId;
    data['dept_province'] = this.deptProvince;
    data['way_id'] = this.wayId;
    data['way_name'] = this.wayName;
    data['sub_district'] = this.subDistrict;
    data['district'] = this.district;
    data['province'] = this.province;
    data['km_from'] = this.kmFrom;
    data['km_to'] = this.kmTo;
    data['create_date'] = this.createDate;
    data['create_by'] = this.createBy;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['collaboration'] = this.collaboration;
    data['is_open'] = this.isOpen;
    data['Total'] = this.total;
    data['TotalOver'] = this.totalOver;
    data['image_path1'] = this.imagePath1;
    data['image_path2'] = this.imagePath2;
    data['image_name1'] = this.imageName1;
    data['image_name2'] = this.imageName2;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    return data;
  }
}
