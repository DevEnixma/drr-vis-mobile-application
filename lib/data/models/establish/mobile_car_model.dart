class MobileCarModel {
  String? createDate;
  String? tdId;
  dynamic arrestId;
  String? tId;
  int? vehicleClassId;
  int? vehicleClassIdRef;
  String? masterialName;
  String? lpHeadNo;
  int? lpHeadProvinceId;
  String? lpTailNo;
  int? lpTailProvinceId;
  String? lpHead;
  String? lpTail;
  dynamic driverShaft;
  dynamic ds1;
  dynamic ds2;
  dynamic ds3;
  dynamic ds4;
  dynamic ds5;
  dynamic ds6;
  dynamic ds7;
  String? vehicleClassDesc;
  String? grossWeight;
  String? grossWeightOver;
  String? legalWeight;
  String? isOverWeightDesc;
  String? isOverWeight;
  dynamic driveShaftOver;
  dynamic driverName;
  String? imagePath1;
  String? vehicleClassName;
  String? vehicleClassDesc2;
  String? vehicleClassDesc3;
  String? vehicleClassLegalWeight;
  String? vehicleClassLegalDriveShaft;
  String? vehicleClassLegalDriveShaftRef;
  String? lpHeadProvinceName;
  int? lpHeadProvinceIdPpa;
  String? lpTailProvinceName;
  int? lpTailProvinceIdPpa;
  dynamic isArrested;
  dynamic acceptWeight;
  dynamic acceptWeightBy;
  int? isArrestedStatus;

  MobileCarModel.empty();

  MobileCarModel(
      {this.createDate,
      this.tdId,
      this.arrestId,
      this.tId,
      this.vehicleClassId,
      this.vehicleClassIdRef,
      this.masterialName,
      this.lpHeadNo,
      this.lpHeadProvinceId,
      this.lpTailNo,
      this.lpTailProvinceId,
      this.lpHead,
      this.lpTail,
      this.driverShaft,
      this.ds1,
      this.ds2,
      this.ds3,
      this.ds4,
      this.ds5,
      this.ds6,
      this.ds7,
      this.vehicleClassDesc,
      this.grossWeight,
      this.grossWeightOver,
      this.legalWeight,
      this.isOverWeightDesc,
      this.isOverWeight,
      this.driveShaftOver,
      this.driverName,
      this.imagePath1,
      this.vehicleClassName,
      this.vehicleClassDesc2,
      this.vehicleClassDesc3,
      this.vehicleClassLegalWeight,
      this.vehicleClassLegalDriveShaft,
      this.vehicleClassLegalDriveShaftRef,
      this.lpHeadProvinceName,
      this.lpHeadProvinceIdPpa,
      this.lpTailProvinceName,
      this.lpTailProvinceIdPpa,
      this.isArrested,
      this.acceptWeight,
      this.acceptWeightBy,
      this.isArrestedStatus});

  MobileCarModel.fromJson(Map<String, dynamic> json) {
    createDate = json['create_date'];
    tdId = json['td_id'];
    arrestId = json['arrest_id'];
    tId = json['t_id'];
    vehicleClassId = json['vehicle_class_id'];
    vehicleClassIdRef = json['vehicle_class_id_ref'];
    masterialName = json['masterial_name'];
    lpHeadNo = json['lp_head_no'];
    lpHeadProvinceId = json['lp_head_province_id'];
    lpTailNo = json['lp_tail_no'];
    lpTailProvinceId = json['lp_tail_province_id'];
    lpHead = json['lp_head'];
    lpTail = json['lp_tail'];
    driverShaft = json['driver_shaft'];
    ds1 = json['ds_1'];
    ds2 = json['ds_2'];
    ds3 = json['ds_3'];
    ds4 = json['ds_4'];
    ds5 = json['ds_5'];
    ds6 = json['ds_6'];
    ds7 = json['ds_7'];
    vehicleClassDesc = json['vehicle_class_desc'];
    grossWeight = json['gross_weight'];
    grossWeightOver = json['gross_weight_over'];
    legalWeight = json['legal_weight'];
    isOverWeightDesc = json['is_over_weight_desc'];
    isOverWeight = json['is_over_weight'];
    driveShaftOver = json['drive_shaft_over'];
    driverName = json['driver_name'];
    imagePath1 = json['image_path1'];
    vehicleClassName = json['vehicle_class_name'];
    vehicleClassDesc2 = json['vehicle_class_desc2'];
    vehicleClassDesc3 = json['vehicle_class_desc3'];
    vehicleClassLegalWeight = json['vehicle_class_legal_weight'];
    vehicleClassLegalDriveShaft = json['vehicle_class_legal_drive_shaft'];
    vehicleClassLegalDriveShaftRef = json['vehicle_class_legal_drive_shaft_ref'];
    lpHeadProvinceName = json['lp_head_province_name'];
    lpHeadProvinceIdPpa = json['lp_head_province_id_ppa'];
    lpTailProvinceName = json['lp_tail_province_name'];
    lpTailProvinceIdPpa = json['lp_tail_province_id_ppa'];
    isArrested = json['is_arrested'];
    acceptWeight = json['accept_weight'];
    acceptWeightBy = json['accept_weight_by'];
    isArrestedStatus = json['is_arrested_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_date'] = this.createDate;
    data['td_id'] = this.tdId;
    data['arrest_id'] = this.arrestId;
    data['t_id'] = this.tId;
    data['vehicle_class_id'] = this.vehicleClassId;
    data['vehicle_class_id_ref'] = this.vehicleClassIdRef;
    data['masterial_name'] = this.masterialName;
    data['lp_head_no'] = this.lpHeadNo;
    data['lp_head_province_id'] = this.lpHeadProvinceId;
    data['lp_tail_no'] = this.lpTailNo;
    data['lp_tail_province_id'] = this.lpTailProvinceId;
    data['lp_head'] = this.lpHead;
    data['lp_tail'] = this.lpTail;
    data['driver_shaft'] = this.driverShaft;
    data['ds_1'] = this.ds1;
    data['ds_2'] = this.ds2;
    data['ds_3'] = this.ds3;
    data['ds_4'] = this.ds4;
    data['ds_5'] = this.ds5;
    data['ds_6'] = this.ds6;
    data['ds_7'] = this.ds7;
    data['vehicle_class_desc'] = this.vehicleClassDesc;
    data['gross_weight'] = this.grossWeight;
    data['gross_weight_over'] = this.grossWeightOver;
    data['legal_weight'] = this.legalWeight;
    data['is_over_weight_desc'] = this.isOverWeightDesc;
    data['is_over_weight'] = this.isOverWeight;
    data['drive_shaft_over'] = this.driveShaftOver;
    data['driver_name'] = this.driverName;
    data['image_path1'] = this.imagePath1;
    data['vehicle_class_name'] = this.vehicleClassName;
    data['vehicle_class_desc2'] = this.vehicleClassDesc2;
    data['vehicle_class_desc3'] = this.vehicleClassDesc3;
    data['vehicle_class_legal_weight'] = this.vehicleClassLegalWeight;
    data['vehicle_class_legal_drive_shaft'] = this.vehicleClassLegalDriveShaft;
    data['vehicle_class_legal_drive_shaft_ref'] = this.vehicleClassLegalDriveShaftRef;
    data['lp_head_province_name'] = this.lpHeadProvinceName;
    data['lp_head_province_id_ppa'] = this.lpHeadProvinceIdPpa;
    data['lp_tail_province_name'] = this.lpTailProvinceName;
    data['lp_tail_province_id_ppa'] = this.lpTailProvinceIdPpa;
    data['is_arrested'] = this.isArrested;
    data['accept_weight'] = this.acceptWeight;
    data['accept_weight_by'] = this.acceptWeightBy;
    data['is_arrested_status'] = this.isArrestedStatus;
    return data;
  }

  MobileCarModel copyWith({
    String? createDate,
    String? tdId,
    dynamic arrestId,
    String? tId,
    int? vehicleClassId,
    int? vehicleClassIdRef,
    String? masterialName,
    String? lpHeadNo,
    int? lpHeadProvinceId,
    String? lpTailNo,
    int? lpTailProvinceId,
    String? lpHead,
    String? lpTail,
    dynamic driverShaft,
    dynamic ds1,
    dynamic ds2,
    dynamic ds3,
    dynamic ds4,
    dynamic ds5,
    dynamic ds6,
    dynamic ds7,
    String? vehicleClassDesc,
    String? grossWeight,
    String? grossWeightOver,
    String? legalWeight,
    String? isOverWeightDesc,
    String? isOverWeight,
    dynamic driveShaftOver,
    dynamic driverName,
    String? imagePath1,
    String? vehicleClassName,
    String? vehicleClassDesc2,
    String? vehicleClassDesc3,
    String? vehicleClassLegalWeight,
    String? vehicleClassLegalDriveShaft,
    String? vehicleClassLegalDriveShaftRef,
    String? lpHeadProvinceName,
    int? lpHeadProvinceIdPpa,
    String? lpTailProvinceName,
    int? lpTailProvinceIdPpa,
    dynamic isArrested,
    dynamic acceptWeight,
    dynamic acceptWeightBy,
    int? isArrestedStatus,
  }) {
    return MobileCarModel(
      createDate: createDate ?? this.createDate,
      tdId: tdId ?? this.tdId,
      arrestId: arrestId ?? this.arrestId,
      tId: tId ?? this.tId,
      vehicleClassId: vehicleClassId ?? this.vehicleClassId,
      vehicleClassIdRef: vehicleClassIdRef ?? this.vehicleClassIdRef,
      masterialName: masterialName ?? this.masterialName,
      lpHeadNo: lpHeadNo ?? this.lpHeadNo,
      lpHeadProvinceId: lpHeadProvinceId ?? this.lpHeadProvinceId,
      lpTailNo: lpTailNo ?? this.lpTailNo,
      lpTailProvinceId: lpTailProvinceId ?? this.lpTailProvinceId,
      lpHead: lpHead ?? this.lpHead,
      lpTail: lpTail ?? this.lpTail,
      driverShaft: driverShaft ?? this.driverShaft,
      ds1: ds1 ?? this.ds1,
      ds2: ds2 ?? this.ds2,
      ds3: ds3 ?? this.ds3,
      ds4: ds4 ?? this.ds4,
      ds5: ds5 ?? this.ds5,
      ds6: ds6 ?? this.ds6,
      ds7: ds7 ?? this.ds7,
      vehicleClassDesc: vehicleClassDesc ?? this.vehicleClassDesc,
      grossWeight: grossWeight ?? this.grossWeight,
      grossWeightOver: grossWeightOver ?? this.grossWeightOver,
      legalWeight: legalWeight ?? this.legalWeight,
      isOverWeightDesc: isOverWeightDesc ?? this.isOverWeightDesc,
      isOverWeight: isOverWeight ?? this.isOverWeight,
      driveShaftOver: driveShaftOver ?? this.driveShaftOver,
      driverName: driverName ?? this.driverName,
      imagePath1: imagePath1 ?? this.imagePath1,
      vehicleClassName: vehicleClassName ?? this.vehicleClassName,
      vehicleClassDesc2: vehicleClassDesc2 ?? this.vehicleClassDesc2,
      vehicleClassDesc3: vehicleClassDesc3 ?? this.vehicleClassDesc3,
      vehicleClassLegalWeight: vehicleClassLegalWeight ?? this.vehicleClassLegalWeight,
      vehicleClassLegalDriveShaft: vehicleClassLegalDriveShaft ?? this.vehicleClassLegalDriveShaft,
      vehicleClassLegalDriveShaftRef: vehicleClassLegalDriveShaftRef ?? this.vehicleClassLegalDriveShaftRef,
      lpHeadProvinceName: lpHeadProvinceName ?? this.lpHeadProvinceName,
      lpHeadProvinceIdPpa: lpHeadProvinceIdPpa ?? this.lpHeadProvinceIdPpa,
      lpTailProvinceName: lpTailProvinceName ?? this.lpTailProvinceName,
      lpTailProvinceIdPpa: lpTailProvinceIdPpa ?? this.lpTailProvinceIdPpa,
      isArrested: isArrested ?? this.isArrested,
      acceptWeight: acceptWeight ?? this.acceptWeight,
      acceptWeightBy: acceptWeightBy ?? this.acceptWeightBy,
      isArrestedStatus: isArrestedStatus ?? this.isArrestedStatus,
    );
  }
}
