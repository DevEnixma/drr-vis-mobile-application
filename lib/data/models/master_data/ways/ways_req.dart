class WaysReq {
  int? page;
  int? pageSize;
  String? order;
  String? wayCode;
  String? province;

  WaysReq.empty();

  WaysReq({this.page, this.pageSize, this.order, this.wayCode, this.province});

  WaysReq.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    order = json['order'];
    wayCode = json['way_code'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['order'] = this.order;
    data['way_code'] = this.wayCode;
    data['province'] = this.province;
    return data;
  }
}
