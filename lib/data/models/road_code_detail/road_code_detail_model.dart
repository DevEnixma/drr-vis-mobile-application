class RoadCodeDetailModel {
  int? roadId;
  int? deptid;
  String? roadCode;
  String? roadName;
  String? province;
  String? district;
  double? distance;
  double? lonStart;
  double? lonEnd;
  double? latStart;
  double? latEnd;

  RoadCodeDetailModel.empty();

  RoadCodeDetailModel({this.roadId, this.deptid, this.roadCode, this.roadName, this.province, this.district, this.distance, this.lonStart, this.lonEnd, this.latStart, this.latEnd});

  RoadCodeDetailModel.fromJson(Map<String, dynamic> json) {
    roadId = json['road_id'];
    deptid = json['deptid'];
    roadCode = json['road_code'];
    roadName = json['road_name'];
    province = json['province'];
    district = json['district'];
    distance = json['distance'];
    lonStart = json['lon_start'];
    lonEnd = json['lon_end'];
    latStart = json['lat_start'];
    latEnd = json['lat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['road_id'] = this.roadId;
    data['deptid'] = this.deptid;
    data['road_code'] = this.roadCode;
    data['road_name'] = this.roadName;
    data['province'] = this.province;
    data['district'] = this.district;
    data['distance'] = this.distance;
    data['lon_start'] = this.lonStart;
    data['lon_end'] = this.lonEnd;
    data['lat_start'] = this.latStart;
    data['lat_end'] = this.latEnd;
    return data;
  }
}
