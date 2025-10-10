class PositionMiddleModel {
  double? positionMiddleLat;
  double? positionMiddleLng;

  PositionMiddleModel({this.positionMiddleLat, this.positionMiddleLng});

  PositionMiddleModel.fromJson(Map<String, dynamic> json) {
    positionMiddleLat = json['position_middle_lat'];
    positionMiddleLng = json['position_middle_lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position_middle_lat'] = this.positionMiddleLat;
    data['position_middle_lng'] = this.positionMiddleLng;
    return data;
  }
}
