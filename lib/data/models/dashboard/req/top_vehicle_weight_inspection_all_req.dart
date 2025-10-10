class TopVehicleWeightInspectionAllReq {
  String? startDate;
  String? endDate;

  TopVehicleWeightInspectionAllReq({this.startDate, this.endDate});

  TopVehicleWeightInspectionAllReq.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
