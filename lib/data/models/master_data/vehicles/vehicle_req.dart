class VehicleReq {
  int? page;
  int? pageSize;

  VehicleReq({this.page, this.pageSize});

  VehicleReq.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    return data;
  }
}
