class ArrestLogDetailModelRes {
  String? id;
  String? tdid;
  String? recordNo;
  String? recordLocation;
  String? recordDate;
  String? recordTime;
  String? witnessFullname;
  String? witnessRace;
  String? witnessNationality;
  String? witnessOcupation;
  String? addressNo;
  String? addressMoo;
  String? addressRoad;
  String? addressSoi;
  String? subDistrict;
  String? district;
  String? province;
  String? phoneNumber;
  String? employerFullname;
  String? truckBrand;
  String? vehicleRegistrationPlate;
  String? vehicleType;
  String? vehicleAxle;
  String? vehicleRubber;
  String? vehicleTowType;
  String? towVehicleRegistrationPlateTail;
  String? towType;
  String? towAxle;
  String? towRubber;
  String? distanceKingpin;
  String? truckCarrierType;
  String? ruralRoadNumber;
  String? sourceProvince;
  String? destinationProvince;
  String? weightStationType;
  String? explain;
  String? truckTotalWeight;
  String? overWeight;
  String? legalWeight;
  String? annoucementNo;
  String? truckRegistrationPlate;
  String? truckRegistrationPlateCopy;
  String? truckLicenseType;
  String? slipWeightFromCompany;
  String? slipWeightFromWeightUnit;
  String? localeRuralRoadNo;
  String? localeKm;
  String? localeSubDistrict;
  String? localeDistrict;
  String? localeProvince;
  String? localeDate;
  dynamic localeTime;
  String? confesstion;
  String? confesstionOther;
  int? evidence;
  int? torture;
  int? tellLaw;
  String? tellLawEmail;
  String? tellLawDate;
  dynamic tellLawTime;
  int? tellLawProsecutor;
  String? tellLawProsecutorEmail;
  String? tellLawProsecutorDate;
  dynamic tellLawProsecutorTime;
  int? provincialAdmin;
  String? isNotRecord;
  String? policeStation;
  String? employerOwner;
  String? truckOwner;
  String? factoryData;
  String? createdAt;
  String? updatedAt;
  int? provinceId;
  int? districtId;
  int? subDistrictId;
  int? sourceProvinceId;
  int? destinationProvinceId;
  int? localeProvinceId;
  int? localeDistrictId;
  int? localeSubDistrictId;

  ArrestLogDetailModelRes.empty();

  ArrestLogDetailModelRes({
    this.id,
    this.tdid,
    this.recordNo,
    this.recordLocation,
    this.recordDate,
    this.recordTime,
    this.witnessFullname,
    this.witnessRace,
    this.witnessNationality,
    this.witnessOcupation,
    this.addressNo,
    this.addressMoo,
    this.addressRoad,
    this.addressSoi,
    this.subDistrict,
    this.district,
    this.province,
    this.phoneNumber,
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
    this.truckTotalWeight,
    this.overWeight,
    this.legalWeight,
    this.annoucementNo,
    this.truckRegistrationPlate,
    this.truckRegistrationPlateCopy,
    this.truckLicenseType,
    this.slipWeightFromCompany,
    this.slipWeightFromWeightUnit,
    this.localeRuralRoadNo,
    this.localeKm,
    this.localeSubDistrict,
    this.localeDistrict,
    this.localeProvince,
    this.localeDate,
    this.localeTime,
    this.confesstion,
    this.confesstionOther,
    this.evidence,
    this.torture,
    this.tellLaw,
    this.tellLawEmail,
    this.tellLawDate,
    this.tellLawTime,
    this.tellLawProsecutor,
    this.tellLawProsecutorEmail,
    this.tellLawProsecutorDate,
    this.tellLawProsecutorTime,
    this.provincialAdmin,
    this.isNotRecord,
    this.policeStation,
    this.employerOwner,
    this.truckOwner,
    this.factoryData,
    this.createdAt,
    this.updatedAt,
    this.provinceId,
    this.districtId,
    this.subDistrictId,
    this.sourceProvinceId,
    this.destinationProvinceId,
    this.localeProvinceId,
    this.localeDistrictId,
    this.localeSubDistrictId,
  });

  ArrestLogDetailModelRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tdid = json['tdid'];
    recordNo = json['record_no'];
    recordLocation = json['record_location'];
    recordDate = json['record_date'];
    recordTime = json['record_time'];
    witnessFullname = json['witness_fullname'];
    witnessRace = json['witness_race'];
    witnessNationality = json['witness_nationality'];
    witnessOcupation = json['witness_ocupation'];
    addressNo = json['address_no'];
    addressMoo = json['address_moo'];
    addressRoad = json['address_road'];
    addressSoi = json['address_soi'];
    subDistrict = json['sub_district'];
    district = json['district'];
    province = json['province'];
    phoneNumber = json['phone_number'];
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
    truckTotalWeight = json['truck_total_weight'];
    overWeight = json['over_weight'];
    legalWeight = json['legal_weight'];
    annoucementNo = json['annoucement_no'];
    truckRegistrationPlate = json['truck_registration_plate'];
    truckRegistrationPlateCopy = json['truck_registration_plate_copy'];
    truckLicenseType = json['truck_license_type'];
    slipWeightFromCompany = json['slip_weight_from_company'];
    slipWeightFromWeightUnit = json['slip_weight_from_weight_unit'];
    localeRuralRoadNo = json['locale_rural_road_no'];
    localeKm = json['locale_km'];
    localeSubDistrict = json['locale_sub_district'];
    localeDistrict = json['locale_district'];
    localeProvince = json['locale_province'];
    localeDate = json['locale_date'];
    localeTime = json['locale_time'];
    confesstion = json['confesstion'];
    confesstionOther = json['confesstion_other'];
    evidence = json['evidence'];
    torture = json['torture'];
    tellLaw = json['tell_law'];
    tellLawEmail = json['tell_law_email'];
    tellLawDate = json['tell_law_date'];
    tellLawTime = json['tell_law_time'];
    tellLawProsecutor = json['tell_law_prosecutor'];
    tellLawProsecutorEmail = json['tell_law_prosecutor_email'];
    tellLawProsecutorDate = json['tell_law_prosecutor_date'];
    tellLawProsecutorTime = json['tell_law_prosecutor_time'];
    provincialAdmin = json['provincial_admin'];
    isNotRecord = json['is_not_record'];
    policeStation = json['police_station'];
    employerOwner = json['employer_owner'];
    truckOwner = json['truck_owner'];
    factoryData = json['factory_data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    subDistrictId = json['sub_district_id'];
    sourceProvinceId = json['source_province_id'];
    destinationProvinceId = json['destination_province_id'];
    localeProvinceId = json['locale_province_id'];
    localeDistrictId = json['locale_district_id'];
    localeSubDistrictId = json['locale_sub_district_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tdid'] = this.tdid;
    data['record_no'] = this.recordNo;
    data['record_location'] = this.recordLocation;
    data['record_date'] = this.recordDate;
    data['record_time'] = this.recordTime;
    data['witness_fullname'] = this.witnessFullname;
    data['witness_race'] = this.witnessRace;
    data['witness_nationality'] = this.witnessNationality;
    data['witness_ocupation'] = this.witnessOcupation;
    data['address_no'] = this.addressNo;
    data['address_moo'] = this.addressMoo;
    data['address_road'] = this.addressRoad;
    data['address_soi'] = this.addressSoi;
    data['sub_district'] = this.subDistrict;
    data['district'] = this.district;
    data['province'] = this.province;
    data['phone_number'] = this.phoneNumber;
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
    data['truck_total_weight'] = this.truckTotalWeight;
    data['over_weight'] = this.overWeight;
    data['legal_weight'] = this.legalWeight;
    data['annoucement_no'] = this.annoucementNo;
    data['truck_registration_plate'] = this.truckRegistrationPlate;
    data['truck_registration_plate_copy'] = this.truckRegistrationPlateCopy;
    data['truck_license_type'] = this.truckLicenseType;
    data['slip_weight_from_company'] = this.slipWeightFromCompany;
    data['slip_weight_from_weight_unit'] = this.slipWeightFromWeightUnit;
    data['locale_rural_road_no'] = this.localeRuralRoadNo;
    data['locale_km'] = this.localeKm;
    data['locale_sub_district'] = this.localeSubDistrict;
    data['locale_district'] = this.localeDistrict;
    data['locale_province'] = this.localeProvince;
    data['locale_date'] = this.localeDate;
    data['locale_time'] = this.localeTime;
    data['confesstion'] = this.confesstion;
    data['confesstion_other'] = this.confesstionOther;
    data['evidence'] = this.evidence;
    data['torture'] = this.torture;
    data['tell_law'] = this.tellLaw;
    data['tell_law_email'] = this.tellLawEmail;
    data['tell_law_date'] = this.tellLawDate;
    data['tell_law_time'] = this.tellLawTime;
    data['tell_law_prosecutor'] = this.tellLawProsecutor;
    data['tell_law_prosecutor_email'] = this.tellLawProsecutorEmail;
    data['tell_law_prosecutor_date'] = this.tellLawProsecutorDate;
    data['tell_law_prosecutor_time'] = this.tellLawProsecutorTime;
    data['provincial_admin'] = this.provincialAdmin;
    data['is_not_record'] = this.isNotRecord;
    data['police_station'] = this.policeStation;
    data['employer_owner'] = this.employerOwner;
    data['truck_owner'] = this.truckOwner;
    data['factory_data'] = this.factoryData;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    data['sub_district_id'] = this.subDistrictId;
    data['source_province_id'] = this.sourceProvinceId;
    data['destination_province_id'] = this.destinationProvinceId;
    data['locale_province_id'] = this.localeProvinceId;
    data['locale_district_id'] = this.localeDistrictId;
    data['locale_sub_district_id'] = this.localeSubDistrictId;
    return data;
  }
}
