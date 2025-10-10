class ProvinceModelRes {
  int? id;
  String? name;
  int? idPpa;

  ProvinceModelRes.empty();

  ProvinceModelRes({this.id, this.name, this.idPpa});

  ProvinceModelRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idPpa = json['id_ppa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['id_ppa'] = this.idPpa;
    return data;
  }
}
