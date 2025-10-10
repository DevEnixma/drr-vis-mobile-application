class ArrestFormStepThreeReq {
  String? truckTotalWeight;
  String? overWeight;
  String? legalWeight;
  String? annoucementNo;
  String? truckRegistrationPlate;
  String? truckRegistrationPlateCopy;
  String? truckLicenseType;
  String? slipWeightFromCompany;
  String? slipWeightFromWeightUnit;

  ArrestFormStepThreeReq.empty();

  ArrestFormStepThreeReq({
    this.truckTotalWeight,
    this.overWeight,
    this.legalWeight,
    this.annoucementNo,
    this.truckRegistrationPlate,
    this.truckRegistrationPlateCopy,
    this.truckLicenseType,
    this.slipWeightFromCompany,
    this.slipWeightFromWeightUnit,
  });

  ArrestFormStepThreeReq.fromJson(Map<String, dynamic> json) {
    truckTotalWeight = json['truck_total_weight'];
    overWeight = json['over_weight'];
    legalWeight = json['legal_weight'];
    annoucementNo = json['annoucement_no'];
    truckRegistrationPlate = json['truck_registration_plate'];
    truckRegistrationPlateCopy = json['truck_registration_plate_copy'];
    truckLicenseType = json['truck_license_type'];
    slipWeightFromCompany = json['slip_weight_from_company'];
    slipWeightFromWeightUnit = json['slip_weight_from_weight_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['truck_total_weight'] = this.truckTotalWeight;
    data['over_weight'] = this.overWeight;
    data['legal_weight'] = this.legalWeight;
    data['annoucement_no'] = this.annoucementNo;
    data['truck_registration_plate'] = this.truckRegistrationPlate;
    data['truck_registration_plate_copy'] = this.truckRegistrationPlateCopy;
    data['truck_license_type'] = this.truckLicenseType;
    data['slip_weight_from_company'] = this.slipWeightFromCompany;
    data['slip_weight_from_weight_unit'] = this.slipWeightFromWeightUnit;
    return data;
  }
}
