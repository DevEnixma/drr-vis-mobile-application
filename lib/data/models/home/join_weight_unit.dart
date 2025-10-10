class JoinWeightUnitReq {
  String? username;
  int? tId;

  JoinWeightUnitReq.empty();

  JoinWeightUnitReq({this.username, this.tId});

  JoinWeightUnitReq.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    tId = json['t_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['t_id'] = this.tId;
    return data;
  }
}
