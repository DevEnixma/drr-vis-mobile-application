class DashboardSumPlaneRes {
  int? plan;
  String? month;
  int? result;

  DashboardSumPlaneRes({this.plan, this.month, this.result});

  DashboardSumPlaneRes.fromJson(Map<String, dynamic> json) {
    plan = json['plan'];
    month = json['month'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan'] = this.plan;
    data['month'] = this.month;
    data['result'] = this.result;
    return data;
  }
}
