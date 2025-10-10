class SubDistrictsMasterDataModel {
  int? id;
  int? districtId;
  String? nameTh;
  String? nameEn;

  SubDistrictsMasterDataModel.empty();

  SubDistrictsMasterDataModel({this.id, this.districtId, this.nameTh, this.nameEn});

  SubDistrictsMasterDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_id'] = this.districtId;
    data['name_th'] = this.nameTh;
    data['name_en'] = this.nameEn;
    return data;
  }
}
