class DailyWeighedVehiclesSum {
  String? createDate;
  int? stationType;
  String? stationTypeEng;
  String? stationTypeDesc;
  String? total;
  String? over;

  DailyWeighedVehiclesSum.empty();

  DailyWeighedVehiclesSum({this.createDate, this.stationType, this.stationTypeEng, this.stationTypeDesc, this.total, this.over});

  DailyWeighedVehiclesSum.fromJson(Map<String, dynamic> json) {
    createDate = json['create_date'];
    stationType = json['station_type'];
    stationTypeEng = json['station_type_eng'];
    stationTypeDesc = json['station_type_desc'];
    total = json['total'];
    over = json['over'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_date'] = this.createDate;
    data['station_type'] = this.stationType;
    data['station_type_eng'] = this.stationTypeEng;
    data['station_type_desc'] = this.stationTypeDesc;
    data['total'] = this.total;
    data['over'] = this.over;
    return data;
  }
}
