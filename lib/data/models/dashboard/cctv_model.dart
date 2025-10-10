class CCTVResModel {
  int? id;
  int? stationId;
  int? stationType;
  String? ipAddress;
  String? cameraDesc;
  String? rtspHls;
  String? lastUpdate;
  String? sta;
  String? direction;
  String? latitude;
  String? longitude;
  String? axisEnixmaVer;
  int? deptid;
  String? deptname;
  String? wayname;
  String? comment;
  String? detail;
  String? rtspOnvif;
  String? location;
  String? model;
  String? brand;
  String? number;
  String? serialNo;
  int? wid;
  String? wowzaLastupdate;
  int? sentAlert;
  String? username;
  int? isOnline;
  int? isEnable;

  CCTVResModel(
      {this.id,
      this.stationId,
      this.stationType,
      this.ipAddress,
      this.cameraDesc,
      this.rtspHls,
      this.lastUpdate,
      this.sta,
      this.direction,
      this.latitude,
      this.longitude,
      this.axisEnixmaVer,
      this.deptid,
      this.deptname,
      this.wayname,
      this.comment,
      this.detail,
      this.rtspOnvif,
      this.location,
      this.model,
      this.brand,
      this.number,
      this.serialNo,
      this.wid,
      this.wowzaLastupdate,
      this.sentAlert,
      this.username,
      this.isOnline,
      this.isEnable});

  CCTVResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationId = json['station_id'];
    stationType = json['station_type'];
    ipAddress = json['ip_address'];
    cameraDesc = json['camera_desc'];
    rtspHls = json['rtsp_hls'];
    lastUpdate = json['last_update'];
    sta = json['sta'];
    direction = json['direction'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    axisEnixmaVer = json['axis_enixma_ver'];
    deptid = json['deptid'];
    deptname = json['deptname'];
    wayname = json['wayname'];
    comment = json['comment'];
    detail = json['detail'];
    rtspOnvif = json['rtsp_onvif'];
    location = json['location'];
    model = json['model'];
    brand = json['brand'];
    number = json['number'];
    serialNo = json['serial_no'];
    wid = json['wid'];
    wowzaLastupdate = json['wowza_lastupdate'];
    sentAlert = json['sent_alert'];
    username = json['username'];
    isOnline = json['is_online'];
    isEnable = json['is_enable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['station_id'] = this.stationId;
    data['station_type'] = this.stationType;
    data['ip_address'] = this.ipAddress;
    data['camera_desc'] = this.cameraDesc;
    data['rtsp_hls'] = this.rtspHls;
    data['last_update'] = this.lastUpdate;
    data['sta'] = this.sta;
    data['direction'] = this.direction;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['axis_enixma_ver'] = this.axisEnixmaVer;
    data['deptid'] = this.deptid;
    data['deptname'] = this.deptname;
    data['wayname'] = this.wayname;
    data['comment'] = this.comment;
    data['detail'] = this.detail;
    data['rtsp_onvif'] = this.rtspOnvif;
    data['location'] = this.location;
    data['model'] = this.model;
    data['brand'] = this.brand;
    data['number'] = this.number;
    data['serial_no'] = this.serialNo;
    data['wid'] = this.wid;
    data['wowza_lastupdate'] = this.wowzaLastupdate;
    data['sent_alert'] = this.sentAlert;
    data['username'] = this.username;
    data['is_online'] = this.isOnline;
    data['is_enable'] = this.isEnable;
    return data;
  }
}
