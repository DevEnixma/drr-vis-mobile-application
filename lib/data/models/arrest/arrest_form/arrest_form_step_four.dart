class ArrestFormStepFourReq {
  String? localeRuralRoadNo;
  String? localeKm;
  int? localeSubDistrict;
  int? localeDistrict;
  int? localeProvince;
  String? localeDate;
  String? localeTime;
  int? confesstion;
  String? confesstionOther;
  int? evidence;
  int? torture;
  int? tellLaw;
  String? tellLawEmail;
  String? tellLawDate;
  String? tellLawTime;
  int? tellLawProsecutor;
  String? tellLawProsecutorEmail;
  String? tellLawProsecutorDate;
  String? tellLawProsecutorTime;
  int? provincialAdmin;
  String? isNotRecord;
  String? policeStation;
  String? employerOwner;
  String? truckOwner;
  String? factoryData;

  ArrestFormStepFourReq.empty();

  ArrestFormStepFourReq({
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
  });

  ArrestFormStepFourReq.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}
