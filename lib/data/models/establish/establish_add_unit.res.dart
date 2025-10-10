class EstablishAddUnitRes {
  String? deptId;
  String? deptGroup;
  int? deptType;
  int? wid;
  String? wayId;
  String? kmFrom;
  String? kmTo;
  String? createDate;
  String? collaboration;
  String? timeFrom;
  String? timeTo;
  String? tId;

  EstablishAddUnitRes.empty();

  EstablishAddUnitRes({
    this.deptId,
    this.deptGroup,
    this.deptType,
    this.wid,
    this.wayId,
    this.kmFrom,
    this.kmTo,
    this.createDate,
    this.collaboration,
    this.timeFrom,
    this.timeTo,
    this.tId,
  });

  EstablishAddUnitRes.fromJson(Map<String, dynamic> json) {
    try {
      deptId = json['dept_id']?.toString();
      deptGroup = json['dept_group']?.toString();

      if (json['dept_type'] != null) {
        deptType = json['dept_type'] is int ? json['dept_type'] : int.tryParse(json['dept_type'].toString());
      }

      if (json['wid'] != null) {
        wid = json['wid'] is int ? json['wid'] : int.tryParse(json['wid'].toString());
      }

      wayId = json['way_id']?.toString();
      kmFrom = json['km_from']?.toString();
      kmTo = json['km_to']?.toString();
      createDate = json['create_date']?.toString();
      collaboration = json['collaboration']?.toString();
      timeFrom = json['time_from']?.toString();
      timeTo = json['time_to']?.toString();
      tId = json['t_id']?.toString();
    } catch (e) {
      print('Error parsing EstablishAddUnitRes: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dept_id'] = deptId;
    data['dept_group'] = deptGroup;
    data['dept_type'] = deptType;
    data['wid'] = wid;
    data['way_id'] = wayId;
    data['km_from'] = kmFrom;
    data['km_to'] = kmTo;
    data['create_date'] = createDate;
    data['collaboration'] = collaboration;
    data['time_from'] = timeFrom;
    data['time_to'] = timeTo;
    data['t_id'] = tId;
    return data;
  }

  @override
  String toString() {
    return 'EstablishAddUnitRes{deptId: $deptId, deptGroup: $deptGroup, deptType: $deptType, wid: $wid, wayId: $wayId, kmFrom: $kmFrom, kmTo: $kmTo, createDate: $createDate, collaboration: $collaboration, timeFrom: $timeFrom, timeTo: $timeTo, tId: $tId}';
  }
}
