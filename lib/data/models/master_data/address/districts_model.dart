class DistrictsMasterDataModel {
  int? id;
  int? provinceId;
  String? nameTh;
  String? nameEn;

  DistrictsMasterDataModel.empty();

  DistrictsMasterDataModel({this.id, this.provinceId, this.nameTh, this.nameEn});

  DistrictsMasterDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province_id'] = this.provinceId;
    data['name_th'] = this.nameTh;
    data['name_en'] = this.nameEn;
    return data;
  }
}
