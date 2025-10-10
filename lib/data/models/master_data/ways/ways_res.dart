class WaysRes {
  int? id;
  String? wayCode;
  String? province;
  String? deptGroup;
  String? deptId;
  String? name;
  String? subdistrict;
  String? district;
  String? distance;

  WaysRes.empty();

  WaysRes({this.id, this.wayCode, this.province, this.deptGroup, this.deptId, this.name, this.subdistrict, this.district, this.distance});

  WaysRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wayCode = json['way_code'];
    province = json['province'];
    deptGroup = json['dept_group'];
    deptId = json['dept_id'];
    name = json['name'];
    subdistrict = json['subdistrict'];
    district = json['district'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['way_code'] = this.wayCode;
    data['province'] = this.province;
    data['dept_group'] = this.deptGroup;
    data['dept_id'] = this.deptId;
    data['name'] = this.name;
    data['subdistrict'] = this.subdistrict;
    data['district'] = this.district;
    data['distance'] = this.distance;
    return data;
  }
}
