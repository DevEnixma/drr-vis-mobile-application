class WeightAddCarModelReq {
  String? tId;
  String? lpHeadNo;
  int? lpHeadProvinceId;
  int? lpTailProvinceId;
  String? lpTailNo;
  int? vehicleClassId;
  String? materialName;
  double? ds1;
  double? ds2;
  double? ds3;
  double? ds4;
  double? ds5;
  double? ds6;
  double? ds7;
  String? frontImage;
  String? backImage;
  String? leftImage;
  String? rightImage;
  String? slipImage;
  String? licenseImage;
  String? tdId;

  WeightAddCarModelReq.empty();

  WeightAddCarModelReq({
    this.tId,
    this.lpHeadNo,
    this.lpHeadProvinceId,
    this.lpTailProvinceId,
    this.lpTailNo,
    this.vehicleClassId,
    this.materialName,
    this.ds1,
    this.ds2,
    this.ds3,
    this.ds4,
    this.ds5,
    this.ds6,
    this.ds7,
    this.frontImage,
    this.backImage,
    this.leftImage,
    this.rightImage,
    this.slipImage,
    this.licenseImage,
    this.tdId,
  });

  WeightAddCarModelReq.fromJson(Map<String, dynamic> json) {
    tId = json['t_id'];
    lpHeadNo = json['lp_head_no'];
    lpHeadProvinceId = json['lp_head_province_id'];
    lpTailProvinceId = json['lp_tail_province_id'];
    lpTailNo = json['lp_tail_no'];
    vehicleClassId = json['vehicle_class_id'];
    materialName = json['material_name'];
    ds1 = json['ds_1'];
    ds2 = json['ds_2'];
    ds3 = json['ds_3'];
    ds4 = json['ds_4'];
    ds5 = json['ds_5'];
    ds6 = json['ds_6'];
    ds7 = json['ds_7'];
    frontImage = json['front_image'];
    backImage = json['back_image'];
    leftImage = json['left_image'];
    rightImage = json['right_image'];
    slipImage = json['slip_image'];
    licenseImage = json['license_image'];
    tdId = json['td_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t_id'] = this.tId;
    data['lp_head_no'] = this.lpHeadNo;
    data['lp_head_province_id'] = this.lpHeadProvinceId;
    data['lp_tail_province_id'] = this.lpTailProvinceId;
    data['lp_tail_no'] = this.lpTailNo;
    data['vehicle_class_id'] = this.vehicleClassId;
    data['material_name'] = this.materialName;
    data['ds_1'] = this.ds1;
    data['ds_2'] = this.ds2;
    data['ds_3'] = this.ds3;
    data['ds_4'] = this.ds4;
    data['ds_5'] = this.ds5;
    data['ds_6'] = this.ds6;
    data['ds_7'] = this.ds7;
    data['front_image'] = this.frontImage;
    data['back_image'] = this.backImage;
    data['left_image'] = this.leftImage;
    data['right_image'] = this.rightImage;
    data['slip_image'] = this.slipImage;
    data['license_image'] = this.licenseImage;
    data['td_id'] = this.tdId;
    return data;
  }
}
