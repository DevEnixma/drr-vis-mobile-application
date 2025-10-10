class MaterialModelReq {
  String? search;
  int? page;
  int? pageSize;

  MaterialModelReq.empty();

  MaterialModelReq({this.search, this.page, this.pageSize});

  MaterialModelReq.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    page = json['page'];
    pageSize = json['page_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    return data;
  }
}
