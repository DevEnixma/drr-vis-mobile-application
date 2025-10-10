class ArrestModelReq {
  int? page;
  int? pageSize;
  String? order;
  String? yearType;
  String? planYear;
  String? startDate;
  String? endDate;
  int? departmentId;

  ArrestModelReq.empty();

  ArrestModelReq({this.page, this.pageSize, this.order, this.yearType, this.planYear, this.startDate, this.endDate, this.departmentId});

  ArrestModelReq.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    order = json['order'];
    yearType = json['year_type'];
    planYear = json['plan_year'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    departmentId = json['department_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['order'] = this.order;
    data['year_type'] = this.yearType;
    data['plan_year'] = this.planYear;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['department_id'] = this.departmentId;
    return data;
  }
}
