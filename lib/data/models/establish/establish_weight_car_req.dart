class EstablishWeightCarRes {
  int? page;
  int? pageSize;
  String? tid;
  String? isOverWeight;
  String? search;

  EstablishWeightCarRes.empty();

  EstablishWeightCarRes({this.page, this.pageSize, this.tid, this.isOverWeight, this.search});

  EstablishWeightCarRes.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    tid = json['tid'];
    isOverWeight = json['is_over_weight'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['tid'] = this.tid;
    data['is_over_weight'] = this.isOverWeight;
    data['search'] = this.search;
    return data;
  }
}
