class EstablishWeightReq {
  String? startDate;
  String? endDate;
  String? branch;
  String? search;
  String? isJoin;
  String? isOpen;
  int? page;
  int? pageSize;
  String? ordering;

  EstablishWeightReq.empty();

  EstablishWeightReq({
    this.startDate,
    this.endDate,
    this.branch,
    this.isJoin,
    this.isOpen,
    this.page,
    this.pageSize,
    this.ordering,
    this.search,
  });

  EstablishWeightReq.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    branch = json['branch'];
    search = json['search'];
    isJoin = json['is_join'];
    isOpen = json['is_open'];
    page = json['page'];
    pageSize = json['page_size'];
    ordering = json['ordering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['branch'] = this.branch;
    data['search'] = this.search;
    data['is_join'] = this.isJoin;
    data['is_open'] = this.isOpen;
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['ordering'] = this.ordering;
    return data;
  }
}
