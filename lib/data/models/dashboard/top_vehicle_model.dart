class TopVehicleResModel {
  int? wayId;
  String? wayCode;
  String? totalVehicle;
  String? percentage;
  String? percentageFormatted;

  TopVehicleResModel(
      {this.wayId,
      this.wayCode,
      this.totalVehicle,
      this.percentage,
      this.percentageFormatted});

  TopVehicleResModel.fromJson(Map<String, dynamic> json) {
    wayId = json['way_id'];
    wayCode = json['way_code'];
    totalVehicle = json['total_vehicle'];
    percentage = json['percentage'];
    percentageFormatted = json['percentage_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['way_id'] = this.wayId;
    data['way_code'] = this.wayCode;
    data['total_vehicle'] = this.totalVehicle;
    data['percentage'] = this.percentage;
    data['percentage_formatted'] = this.percentageFormatted;
    return data;
  }
}
