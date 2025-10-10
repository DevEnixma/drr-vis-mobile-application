class VehicleWeightInspectionReq {
  String? date;
  String? numberDay;
  String? stationTypeId;

  VehicleWeightInspectionReq({this.date, this.numberDay, this.stationTypeId});

  VehicleWeightInspectionReq.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    numberDay = json['number_day'];
    stationTypeId = json['station_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['number_day'] = this.numberDay;
    data['station_type_id'] = this.stationTypeId;
    return data;
  }
}
