class SubDistrictsReq {
  int? page;
  int? pageSize;
  String? textSearch;
  int? districtId;

  SubDistrictsReq.empty();

  SubDistrictsReq({this.page, this.pageSize, this.textSearch, this.districtId});

  SubDistrictsReq.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    textSearch = json['text_search'];
    districtId = json['district_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['text_search'] = this.textSearch;
    data['district_id'] = this.districtId;
    return data;
  }
}
