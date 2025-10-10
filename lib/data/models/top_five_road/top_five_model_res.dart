class TopFiveRoadModelRes {
  String? roadCode;
  String? roadName;
  String? totalVehicles;
  String? stationaryVehicles;
  String? movingVehicles;
  String? averageSpeedMovingVehiclesKmH;
  String? percentage;
  String? percentageFormatted;

  TopFiveRoadModelRes.empty();

  TopFiveRoadModelRes({this.roadCode, this.roadName, this.totalVehicles, this.stationaryVehicles, this.movingVehicles, this.averageSpeedMovingVehiclesKmH, this.percentage, this.percentageFormatted});

  TopFiveRoadModelRes.fromJson(Map<String, dynamic> json) {
    roadCode = json['road_code'];
    roadName = json['road_name'];
    totalVehicles = json['total_vehicles'];
    stationaryVehicles = json['stationary_vehicles'];
    movingVehicles = json['moving_vehicles'];
    averageSpeedMovingVehiclesKmH = json['average_speed_moving_vehicles_km_h'];
    percentage = json['percentage'];
    percentageFormatted = json['percentage_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['road_code'] = this.roadCode;
    data['road_name'] = this.roadName;
    data['total_vehicles'] = this.totalVehicles;
    data['stationary_vehicles'] = this.stationaryVehicles;
    data['moving_vehicles'] = this.movingVehicles;
    data['average_speed_moving_vehicles_km_h'] = this.averageSpeedMovingVehiclesKmH;
    data['percentage'] = this.percentage;
    data['percentage_formatted'] = this.percentageFormatted;
    return data;
  }
}
