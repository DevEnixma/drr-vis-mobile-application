class EstablishAddUnitReq {
  int? wid;
  String? collaboration;
  String? kmFrom;
  String? kmTo;
  String? file1;
  String? file2;
  double? latitude;
  double? longitude;

  EstablishAddUnitReq.empty();

  EstablishAddUnitReq({this.wid, this.collaboration, this.kmFrom, this.kmTo, this.file1, this.file2, this.latitude, this.longitude});

  EstablishAddUnitReq.fromJson(Map<String, dynamic> json) {
    wid = json['wid'];
    collaboration = json['collaboration'];
    kmFrom = json['km_from'];
    kmTo = json['km_to'];
    file1 = json['file1'];
    file2 = json['file2'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wid'] = this.wid;
    data['collaboration'] = this.collaboration;
    data['km_from'] = this.kmFrom;
    data['km_to'] = this.kmTo;
    data['file1'] = this.file1;
    data['file2'] = this.file2;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
