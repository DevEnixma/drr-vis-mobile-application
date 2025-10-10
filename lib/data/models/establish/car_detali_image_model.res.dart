class CarDetailModelImageRes {
  int? uId;
  String? tdId;
  String? tId;
  String? imagePath0;
  String? imagePath1;
  String? imagePath2;
  String? imagePath3;
  String? imagePath4;
  String? imagePath5;
  String? imagePath6;
  String? imageName0;
  String? imageName1;
  String? imageName2;
  String? imageName3;
  String? imageName4;
  String? imageName5;
  String? imageName6;
  String? imageSlip;
  String? imageDriverId;

  CarDetailModelImageRes.empty();

  CarDetailModelImageRes({this.uId, this.tdId, this.tId, this.imagePath0, this.imagePath1, this.imagePath2, this.imagePath3, this.imagePath4, this.imagePath5, this.imagePath6, this.imageName0, this.imageName1, this.imageName2, this.imageName3, this.imageName4, this.imageName5, this.imageName6, this.imageSlip, this.imageDriverId});

  CarDetailModelImageRes.fromJson(Map<String, dynamic> json) {
    uId = json['u_id'];
    tdId = json['td_id'];
    tId = json['t_id'];
    imagePath0 = json['image_path0'];
    imagePath1 = json['image_path1'];
    imagePath2 = json['image_path2'];
    imagePath3 = json['image_path3'];
    imagePath4 = json['image_path4'];
    imagePath5 = json['image_path5'];
    imagePath6 = json['image_path6'];
    imageName0 = json['image_name0'];
    imageName1 = json['image_name1'];
    imageName2 = json['image_name2'];
    imageName3 = json['image_name3'];
    imageName4 = json['image_name4'];
    imageName5 = json['image_name5'];
    imageName6 = json['image_name6'];
    imageSlip = json['image_slip'];
    imageDriverId = json['image_driver_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['u_id'] = this.uId;
    data['td_id'] = this.tdId;
    data['t_id'] = this.tId;
    data['image_path0'] = this.imagePath0;
    data['image_path1'] = this.imagePath1;
    data['image_path2'] = this.imagePath2;
    data['image_path3'] = this.imagePath3;
    data['image_path4'] = this.imagePath4;
    data['image_path5'] = this.imagePath5;
    data['image_path6'] = this.imagePath6;
    data['image_name0'] = this.imageName0;
    data['image_name1'] = this.imageName1;
    data['image_name2'] = this.imageName2;
    data['image_name3'] = this.imageName3;
    data['image_name4'] = this.imageName4;
    data['image_name5'] = this.imageName5;
    data['image_name6'] = this.imageName6;
    data['image_slip'] = this.imageSlip;
    data['image_driver_id'] = this.imageDriverId;
    return data;
  }
}
