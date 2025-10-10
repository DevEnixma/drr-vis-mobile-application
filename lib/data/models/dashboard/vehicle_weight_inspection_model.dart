class VehicleWeightInspectionModel {
  String? createDate;
  String? filterStation;
  String? totalTitle;
  String? overTitle;
  String? total;
  String? over;

  VehicleWeightInspectionModel(
      {this.createDate,
      this.filterStation,
      this.totalTitle,
      this.overTitle,
      this.total,
      this.over});

  VehicleWeightInspectionModel.fromJson(Map<String, dynamic> json) {
    createDate = json['create_date'];
    filterStation = json['filter_station'];
    totalTitle = json['total_title'];
    overTitle = json['over_title'];
    total = json['total'];
    over = json['over'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_date'] = this.createDate;
    data['filter_station'] = this.filterStation;
    data['total_title'] = this.totalTitle;
    data['over_title'] = this.overTitle;
    data['total'] = this.total;
    data['over'] = this.over;
    return data;
  }
}
