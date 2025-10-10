class TopFiveRoadModelReq {
  int? page;
  int? pageSize;
  String? order;

  TopFiveRoadModelReq.empty();

  TopFiveRoadModelReq({this.page, this.pageSize, this.order});

  TopFiveRoadModelReq.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['order'] = this.order;
    return data;
  }
}
