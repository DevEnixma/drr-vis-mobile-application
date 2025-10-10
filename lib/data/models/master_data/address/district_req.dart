class DistrictsReq {
  int? page;
  int? pageSize;
  String? textSearch;
  int? provinceId;

  DistrictsReq.empty();

  DistrictsReq({this.page, this.pageSize, this.textSearch, this.provinceId});

  DistrictsReq.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    textSearch = json['text_search'];
    provinceId = json['province_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['text_search'] = this.textSearch;
    data['province_id'] = this.provinceId;
    return data;
  }
}
