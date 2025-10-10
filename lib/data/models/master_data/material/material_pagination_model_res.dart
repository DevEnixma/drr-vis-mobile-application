class MaterialPaginationModelRes {
  int? page;
  int? total;
  int? pageSize;
  int? pageCount;
  bool? hasPreviousPage;
  bool? hasNextPage;

  MaterialPaginationModelRes.empty();

  MaterialPaginationModelRes({this.page, this.total, this.pageSize, this.pageCount, this.hasPreviousPage, this.hasNextPage});

  MaterialPaginationModelRes.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    total = json['total'];
    pageSize = json['page_size'];
    pageCount = json['page_count'];
    hasPreviousPage = json['has_previous_page'];
    hasNextPage = json['has_next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total'] = this.total;
    data['page_size'] = this.pageSize;
    data['page_count'] = this.pageCount;
    data['has_previous_page'] = this.hasPreviousPage;
    data['has_next_page'] = this.hasNextPage;
    return data;
  }
}
