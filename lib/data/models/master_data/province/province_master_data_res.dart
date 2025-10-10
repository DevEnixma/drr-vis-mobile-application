class ProvinceMasterDataModel {
  int? id;
  int? pid;
  String? nameTh;
  String? nameEn;
  int? regionId;
  String? regionNameTh;
  String? regionNameEn;

  ProvinceMasterDataModel.empty();

  ProvinceMasterDataModel({this.id, this.pid, this.nameTh, this.nameEn, this.regionId, this.regionNameTh, this.regionNameEn});

  ProvinceMasterDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    regionId = json['region_id'];
    regionNameTh = json['region_name_th'];
    regionNameEn = json['region_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['name_th'] = this.nameTh;
    data['name_en'] = this.nameEn;
    data['region_id'] = this.regionId;
    data['region_name_th'] = this.regionNameTh;
    data['region_name_en'] = this.regionNameEn;
    return data;
  }
}
