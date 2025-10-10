class MobileMasterModel {
  String? tID;
  int? deptID;
  String? deptName;
  String? collaboration;
  String? deptProvince;
  String? wayID;
  String? wayName;
  String? subdistrict;
  String? district;
  String? province;
  String? createDate;
  String? createBy;
  String? timeFrom;
  String? timeTo;
  int? isOpen;
  String? total;
  String? totalOver;
  String? kMFrom;
  String? kMTo;
  String? firstName;
  String? lastName;
  String? imagePath1;
  String? imagePath2;

  MobileMasterModel.empty();

  MobileMasterModel({
    this.tID,
    this.deptID,
    this.deptName,
    this.collaboration,
    this.deptProvince,
    this.wayID,
    this.wayName,
    this.subdistrict,
    this.district,
    this.province,
    this.createDate,
    this.timeFrom,
    this.timeTo,
    this.isOpen,
    this.total,
    this.totalOver,
    this.kMFrom,
    this.kMTo,
    this.createBy,
    this.firstName,
    this.lastName,
    this.imagePath1,
    this.imagePath2,
  });

  MobileMasterModel.fromJson(Map<String, dynamic> json) {
    tID = json['TID'];
    deptID = json['DeptID'];
    deptName = json['DeptName'];
    collaboration = json['Collaboration'];
    deptProvince = json['DeptProvince'];
    wayID = json['WayID'];
    wayName = json['WayName'];
    subdistrict = json['Subdistrict'];
    district = json['District'];
    province = json['Province'];
    createDate = json['CreateDate'];
    createBy = json['CreateBy'];
    timeFrom = json['TimeFrom'];
    timeTo = json['TimeTo'] ?? '';
    isOpen = json['IsOpen'];
    total = json['Total'];
    totalOver = json['TotalOver'];
    kMFrom = json['KMFrom'];
    kMTo = json['KMTo'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    imagePath1 = json['image_path1'];
    imagePath2 = json['image_path2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TID'] = this.tID;
    data['DeptID'] = this.deptID;
    data['DeptName'] = this.deptName;
    data['Collaboration'] = this.collaboration;
    data['DeptProvince'] = this.deptProvince;
    data['WayID'] = this.wayID;
    data['WayName'] = this.wayName;
    data['Subdistrict'] = this.subdistrict;
    data['District'] = this.district;
    data['Province'] = this.province;
    data['CreateDate'] = this.createDate;
    data['CreateBy'] = this.createBy;
    data['TimeFrom'] = this.timeFrom;
    data['TimeTo'] = this.timeTo;
    data['IsOpen'] = this.isOpen;
    data['Total'] = this.total;
    data['TotalOver'] = this.totalOver;
    data['KMFrom'] = this.kMFrom;
    data['KMTo'] = this.kMTo;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['image_path1'] = this.imagePath1;
    data['image_path2'] = this.imagePath2;
    return data;
  }

  // เพิ่ม copyWith
  MobileMasterModel copyWith({
    String? tID,
    int? deptID,
    String? deptName,
    String? collaboration,
    String? deptProvince,
    String? wayID,
    String? wayName,
    String? subdistrict,
    String? district,
    String? province,
    String? createDate,
    String? createBy,
    String? timeFrom,
    String? timeTo,
    int? isOpen,
    String? total,
    String? totalOver,
    String? kMFrom,
    String? kMTo,
    String? firstName,
    String? lastName,
    String? imagePath1,
    String? imagePath2,
  }) {
    return MobileMasterModel(
      tID: tID ?? this.tID,
      deptID: deptID ?? this.deptID,
      deptName: deptName ?? this.deptName,
      collaboration: collaboration ?? this.collaboration,
      deptProvince: deptProvince ?? this.deptProvince,
      wayID: wayID ?? this.wayID,
      wayName: wayName ?? this.wayName,
      subdistrict: subdistrict ?? this.subdistrict,
      district: district ?? this.district,
      province: province ?? this.province,
      createDate: createDate ?? this.createDate,
      createBy: createBy ?? this.createBy,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      isOpen: isOpen ?? this.isOpen,
      total: total ?? this.total,
      totalOver: totalOver ?? this.totalOver,
      kMFrom: kMFrom ?? this.kMFrom,
      kMTo: kMTo ?? this.kMTo,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imagePath1: imagePath1 ?? this.imagePath1,
      imagePath2: imagePath2 ?? this.imagePath2,
    );
  }
}
