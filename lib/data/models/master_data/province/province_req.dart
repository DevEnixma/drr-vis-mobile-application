class ProvinceModelReq {
  int? page;
  int? pageSize;
  String? textSearch;

  ProvinceModelReq.empty();

  ProvinceModelReq({this.page, this.pageSize, this.textSearch});

  ProvinceModelReq.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    textSearch = json['text_search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['text_search'] = this.textSearch;
    return data;
  }
}
