class CarDetailModelRes {
  String? createDate;
  String? tdId;
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
  String? driverShaft;
  String? acceptWeight;
  String? acceptWeightBy;
  String? ds1;
  String? ds2;
  String? ds3;
  String? ds4;
  String? ds5;
  String? ds6;
  String? ds7;
  String? vehicleClassDesc;
  String? grossWeight;
  String? grossWeightOver;
  String? legalWeight;
  String? isOverWeightDesc;
  String? isOverWeight;
  String? driveShaftOver;
  String? driverName;
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

  CarDetailModelRes({
    this.createDate,
    this.tdId,
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
    this.acceptWeight,
    this.acceptWeightBy,
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
  });

  CarDetailModelRes.fromJson(Map<String, dynamic> json) {
    createDate = json['create_date'] ?? '';
    tdId = json['td_id'] ?? '';
    tId = json['t_id'] ?? '';
    vehicleClassId = json['vehicle_class_id'] is int ? json['vehicle_class_id'] : int.tryParse(json['vehicle_class_id'].toString());
    vehicleClassIdRef = json['vehicle_class_id_ref'] is int ? json['vehicle_class_id_ref'] : int.tryParse(json['vehicle_class_id_ref'].toString());
    masterialName = json['masterial_name'] ?? '';
    lpHeadNo = json['lp_head_no'] ?? '';
    lpHeadProvinceId = json['lp_head_province_id'] is int ? json['lp_head_province_id'] : int.tryParse(json['lp_head_province_id'].toString());
    lpTailNo = json['lp_tail_no'] ?? '';
    lpTailProvinceId = json['lp_tail_province_id'] is int ? json['lp_tail_province_id'] : int.tryParse(json['lp_tail_province_id'].toString());
    lpHead = json['lp_head'] ?? '';
    lpTail = json['lp_tail'];
    driverShaft = json['driver_shaft'] ?? '';
    acceptWeight = json['accept_weight'];
    acceptWeightBy = json['accept_weight_by'];
    ds1 = json['ds_1'];
    ds2 = json['ds_2'];
    ds3 = json['ds_3'];
    ds4 = json['ds_4'];
    ds5 = json['ds_5'];
    ds6 = json['ds_6'];
    ds7 = json['ds_7'];
    vehicleClassDesc = json['vehicle_class_desc'] ?? '';
    grossWeight = json['gross_weight'];
    grossWeightOver = json['gross_weight_over'];
    legalWeight = json['legal_weight'];
    isOverWeightDesc = json['is_over_weight_desc'] ?? '';
    isOverWeight = json['is_over_weight'] ?? '';
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
    lpHeadProvinceIdPpa = json['lp_head_province_id_ppa'] is int ? json['lp_head_province_id_ppa'] : int.tryParse(json['lp_head_province_id_ppa'].toString());
    lpTailProvinceName = json['lp_tail_province_name'];
    lpTailProvinceIdPpa = json['lp_tail_province_id_ppa'] is int ? json['lp_tail_province_id_ppa'] : int.tryParse(json['lp_tail_province_id_ppa'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_date'] = this.createDate;
    data['td_id'] = this.tdId;
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
    data['accept_weight'] = this.acceptWeight;
    data['accept_weight_by'] = this.acceptWeightBy;
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
    return data;
  }
}
