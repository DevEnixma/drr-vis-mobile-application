class ArrestPaginationRes {
  int? page;
  int? pageSize;
  int? total;
  int? pageCount;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ArrestPaginationRes({this.page, this.pageSize, this.total, this.pageCount, this.hasPreviousPage, this.hasNextPage});

  ArrestPaginationRes.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    total = json['total'];
    pageCount = json['page_count'];
    hasPreviousPage = json['has_previous_page'];
    hasNextPage = json['has_next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['total'] = this.total;
    data['page_count'] = this.pageCount;
    data['has_previous_page'] = this.hasPreviousPage;
    data['has_next_page'] = this.hasNextPage;
    return data;
  }
}
