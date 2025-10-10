class VehicleRes {
  int? vId;
  int? vehicleClassId;
  int? vehicleClassIdRef;
  String? vehicleClassName;
  String? vehicleClassDesc;
  String? legalWeight;
  String? driveShaft;
  String? driveShaftRef;
  String? vehicleClassDesc2;
  String? vehicleClassDesc3;

  VehicleRes.empty();

  VehicleRes({this.vId, this.vehicleClassId, this.vehicleClassIdRef, this.vehicleClassName, this.vehicleClassDesc, this.legalWeight, this.driveShaft, this.driveShaftRef, this.vehicleClassDesc2, this.vehicleClassDesc3});

  VehicleRes.fromJson(Map<String, dynamic> json) {
    vId = json['v_id'];
    vehicleClassId = json['vehicle_class_id'];
    vehicleClassIdRef = json['vehicle_class_id_ref'];
    vehicleClassName = json['vehicle_class_name'];
    vehicleClassDesc = json['vehicle_class_desc'];
    legalWeight = json['legal_weight'];
    driveShaft = json['drive_shaft'];
    driveShaftRef = json['drive_shaft_ref'];
    vehicleClassDesc2 = json['vehicle_class_desc_2'];
    vehicleClassDesc3 = json['vehicle_class_desc_3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v_id'] = this.vId;
    data['vehicle_class_id'] = this.vehicleClassId;
    data['vehicle_class_id_ref'] = this.vehicleClassIdRef;
    data['vehicle_class_name'] = this.vehicleClassName;
    data['vehicle_class_desc'] = this.vehicleClassDesc;
    data['legal_weight'] = this.legalWeight;
    data['drive_shaft'] = this.driveShaft;
    data['drive_shaft_ref'] = this.driveShaftRef;
    data['vehicle_class_desc_2'] = this.vehicleClassDesc2;
    data['vehicle_class_desc_3'] = this.vehicleClassDesc3;
    return data;
  }
}
