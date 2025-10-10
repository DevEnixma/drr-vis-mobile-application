class ArrestFormStepTwoReq {
  String? employerFullname;
  String? truckBrand;
  String? vehicleRegistrationPlate;
  String? vehicleType;
  String? vehicleAxle;
  String? vehicleRubber;
  int? vehicleTowType;
  String? towVehicleRegistrationPlateTail;
  String? towType;
  String? towAxle;
  String? towRubber;
  String? distanceKingpin;
  int? truckCarrierType;
  String? ruralRoadNumber;
  int? sourceProvince;
  int? destinationProvince;
  int? weightStationType;
  String? explain;

  ArrestFormStepTwoReq.empty();

  ArrestFormStepTwoReq({
    this.employerFullname,
    this.truckBrand,
    this.vehicleRegistrationPlate,
    this.vehicleType,
    this.vehicleAxle,
    this.vehicleRubber,
    this.vehicleTowType,
    this.towVehicleRegistrationPlateTail,
    this.towType,
    this.towAxle,
    this.towRubber,
    this.distanceKingpin,
    this.truckCarrierType,
    this.ruralRoadNumber,
    this.sourceProvince,
    this.destinationProvince,
    this.weightStationType,
    this.explain,
  });

  ArrestFormStepTwoReq.fromJson(Map<String, dynamic> json) {
    employerFullname = json['employer_fullname'];
    truckBrand = json['truck_brand'];
    vehicleRegistrationPlate = json['vehicle_registration_plate'];
    vehicleType = json['vehicle_type'];
    vehicleAxle = json['vehicle_axle'];
    vehicleRubber = json['vehicle_rubber'];
    vehicleTowType = json['vehicle_tow_type'];
    towVehicleRegistrationPlateTail = json['tow_vehicle_registration_plate_tail'];
    towType = json['tow_type'];
    towAxle = json['tow_axle'];
    towRubber = json['tow_rubber'];
    distanceKingpin = json['distance_kingpin'];
    truckCarrierType = json['truck_carrier_type'];
    ruralRoadNumber = json['rural_road_number'];
    sourceProvince = json['source_province'];
    destinationProvince = json['destination_province'];
    weightStationType = json['weight_station_type'];
    explain = json['explain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employer_fullname'] = this.employerFullname;
    data['truck_brand'] = this.truckBrand;
    data['vehicle_registration_plate'] = this.vehicleRegistrationPlate;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_axle'] = this.vehicleAxle;
    data['vehicle_rubber'] = this.vehicleRubber;
    data['vehicle_tow_type'] = this.vehicleTowType;
    data['tow_vehicle_registration_plate_tail'] = this.towVehicleRegistrationPlateTail;
    data['tow_type'] = this.towType;
    data['tow_axle'] = this.towAxle;
    data['tow_rubber'] = this.towRubber;
    data['distance_kingpin'] = this.distanceKingpin;
    data['truck_carrier_type'] = this.truckCarrierType;
    data['rural_road_number'] = this.ruralRoadNumber;
    data['source_province'] = this.sourceProvince;
    data['destination_province'] = this.destinationProvince;
    data['weight_station_type'] = this.weightStationType;
    data['explain'] = this.explain;
    return data;
  }
}
