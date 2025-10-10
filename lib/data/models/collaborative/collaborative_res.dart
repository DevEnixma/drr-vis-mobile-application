class CollaborativeRes {
  String? colname;
  bool? isSelected;
  int? id;

  CollaborativeRes({this.colname, this.isSelected, this.id});

  CollaborativeRes.fromJson(Map<String, dynamic> json) {
    colname = json['colname'];
    isSelected = json['is_selected'] ?? false;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colname'] = this.colname;
    data['is_selected'] = this.isSelected;
    data['id'] = this.id;
    return data;
  }
}
