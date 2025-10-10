class RoadCodeCarModelReq {
  int? page;
  int? pageSize;
  String? order;
  String? isOnAssignedRoad;
  String? roadCodes;
  String? search;

  RoadCodeCarModelReq.empty();

  RoadCodeCarModelReq({
    this.page,
    this.pageSize,
    this.order,
    this.isOnAssignedRoad,
    this.roadCodes,
    this.search,
  });

  RoadCodeCarModelReq.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    order = json['order'];
    isOnAssignedRoad = json['is_on_assigned_road'];
    roadCodes = json['road_codes'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['order'] = this.order;
    data['is_on_assigned_road'] = this.isOnAssignedRoad;
    data['road_codes'] = this.roadCodes;
    data['search'] = this.search;
    return data;
  }
}
