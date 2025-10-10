class WeightAddCarModelRes {
  int? tId;
  int? lpHeadNo;
  String? lpHeadProvince;
  int? lpTailNo;
  String? lpTailProvince;
  String? timeStamp;
  int? vehicleClassId;
  String? materialName;
  double? ds1;
  double? ds2;
  double? ds3;
  double? ds4;
  double? ds5;
  double? ds6;
  double? ds7;
  String? isOverWeight;
  double? grossWeight;
  double? grossWeightOver;
  int? legalWeight;
  int? tdId;

  WeightAddCarModelRes.empty();

  WeightAddCarModelRes({
    this.tId,
    this.lpHeadNo,
    this.lpHeadProvince,
    this.lpTailNo,
    this.lpTailProvince,
    this.timeStamp,
    this.vehicleClassId,
    this.materialName,
    this.ds1,
    this.ds2,
    this.ds3,
    this.ds4,
    this.ds5,
    this.ds6,
    this.ds7,
    this.isOverWeight,
    this.grossWeight,
    this.grossWeightOver,
    this.legalWeight,
    this.tdId,
  });

  WeightAddCarModelRes.fromJson(Map<String, dynamic> json) {
    tId = int.tryParse(json['t_id']?.toString() ?? '');
    lpHeadNo = int.tryParse(json['lp_head_no']?.toString() ?? '');
    lpHeadProvince = json['lp_head_province'];
    lpTailNo = int.tryParse(json['lp_tail_no']?.toString() ?? '');
    lpTailProvince = json['lp_tail_province'];
    timeStamp = json['time_stamp'];
    vehicleClassId = int.tryParse(json['vehicle_class_id']?.toString() ?? '');
    materialName = json['material_name'];
    ds1 = double.tryParse(json['ds_1']?.toString() ?? '');
    ds2 = double.tryParse(json['ds_2']?.toString() ?? '');
    ds3 = double.tryParse(json['ds_3']?.toString() ?? '');
    ds4 = double.tryParse(json['ds_4']?.toString() ?? '');
    ds5 = double.tryParse(json['ds_5']?.toString() ?? '');
    ds6 = double.tryParse(json['ds_6']?.toString() ?? '');
    ds7 = double.tryParse(json['ds_7']?.toString() ?? '');
    isOverWeight = json['is_over_weight'];
    grossWeight = double.tryParse(json['gross_weight']?.toString() ?? '');
    grossWeightOver = double.tryParse(json['gross_weight_over']?.toString() ?? '');
    legalWeight = int.tryParse(json['legal_weight']?.toString() ?? '');
    tdId = int.tryParse(json['td_id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t_id'] = this.tId;
    data['lp_head_no'] = this.lpHeadNo;
    data['lp_head_province'] = this.lpHeadProvince;
    data['lp_tail_no'] = this.lpTailNo;
    data['lp_tail_province'] = this.lpTailProvince;
    data['time_stamp'] = this.timeStamp;
    data['vehicle_class_id'] = this.vehicleClassId;
    data['material_name'] = this.materialName;
    data['ds_1'] = this.ds1;
    data['ds_2'] = this.ds2;
    data['ds_3'] = this.ds3;
    data['ds_4'] = this.ds4;
    data['ds_5'] = this.ds5;
    data['ds_6'] = this.ds6;
    data['ds_7'] = this.ds7;
    data['is_over_weight'] = this.isOverWeight;
    data['gross_weight'] = this.grossWeight;
    data['gross_weight_over'] = this.grossWeightOver;
    data['legal_weight'] = this.legalWeight;
    data['td_id'] = this.tdId;
    return data;
  }
}
