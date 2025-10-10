class ArrestFormStepOneReq {
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
  int? subDistrict;
  int? district;
  int? province;
  String? phoneNumber;

  ArrestFormStepOneReq.empty();

  ArrestFormStepOneReq({this.tdid, this.recordNo, this.recordLocation, this.recordDate, this.recordTime, this.witnessFullname, this.witnessRace, this.witnessNationality, this.witnessOcupation, this.addressNo, this.addressMoo, this.addressRoad, this.addressSoi, this.subDistrict, this.district, this.province, this.phoneNumber});

  ArrestFormStepOneReq.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}
