class ReportArrestModelRes {
  String? tdId;
  String? fileType;

  ReportArrestModelRes.empty();

  ReportArrestModelRes({this.tdId, this.fileType});

  ReportArrestModelRes.fromJson(Map<String, dynamic> json) {
    tdId = json['td_id'];
    fileType = json['file_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['td_id'] = this.tdId;
    data['file_type'] = this.fileType;
    return data;
  }
}
