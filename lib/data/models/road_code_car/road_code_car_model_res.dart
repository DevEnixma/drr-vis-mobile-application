class RoadCodeCarModelRes {
  String unitId;
  dynamic driverId;
  int speed;
  Geometry geom;
  String timestamp;
  int roadId;
  String lastUpdatedAt;
  bool isOnAssignedRoad;
  double distanceFromRoad;
  String lastOnRoadTimestamp;
  String plate;
  dynamic provinceId;
  dynamic numBodyAlias;
  String brnDesc;
  String typeDesc;
  String typeCode;
  String kindDesc;
  String kindCode;
  dynamic subKindDescShort;
  dynamic subKindCode;
  dynamic licNo;
  dynamic licEffLocDesc;
  dynamic licDesc;
  dynamic pathDesc;
  dynamic subPathName;
  String wgt;
  dynamic wgtTotal;
  String wheelDesc;
  String unitIdNum;
  dynamic lastRoadChangeDate;
  bool hasOverweightHistory;
  int plateProvinceId;
  String plateNo;
  Road road;
  PlateProvince plateProvince;

  // Constructor หลัก
  RoadCodeCarModelRes({
    required this.unitId,
    this.driverId,
    required this.speed,
    required this.geom,
    required this.timestamp,
    required this.roadId,
    required this.lastUpdatedAt,
    required this.isOnAssignedRoad,
    required this.distanceFromRoad,
    required this.lastOnRoadTimestamp,
    required this.plate,
    this.provinceId,
    this.numBodyAlias,
    required this.brnDesc,
    required this.typeDesc,
    required this.typeCode,
    required this.kindDesc,
    required this.kindCode,
    this.subKindDescShort,
    this.subKindCode,
    this.licNo,
    this.licEffLocDesc,
    this.licDesc,
    this.pathDesc,
    this.subPathName,
    required this.wgt,
    this.wgtTotal,
    required this.wheelDesc,
    required this.unitIdNum,
    this.lastRoadChangeDate,
    required this.hasOverweightHistory,
    required this.plateProvinceId,
    required this.plateNo,
    required this.road,
    required this.plateProvince,
  });

  // Constructor สำหรับ Empty Object
  factory RoadCodeCarModelRes.empty() {
    return RoadCodeCarModelRes(
      unitId: '',
      driverId: null,
      speed: 0,
      geom: Geometry(type: '', coordinates: []),
      timestamp: '',
      roadId: 0,
      lastUpdatedAt: '',
      isOnAssignedRoad: false,
      distanceFromRoad: 0.0,
      lastOnRoadTimestamp: '',
      plate: '',
      provinceId: null,
      numBodyAlias: null,
      brnDesc: '',
      typeDesc: '',
      typeCode: '',
      kindDesc: '',
      kindCode: '',
      subKindDescShort: null,
      subKindCode: null,
      licNo: null,
      licEffLocDesc: null,
      licDesc: null,
      pathDesc: null,
      subPathName: null,
      wgt: '',
      wgtTotal: null,
      wheelDesc: '',
      unitIdNum: '',
      lastRoadChangeDate: null,
      hasOverweightHistory: false,
      plateProvinceId: 0,
      plateNo: '',
      road: Road(roadId: 0, roadName: ''),
      plateProvince: PlateProvince(id: 0, provinceName: ''),
    );
  }

  // Factory Constructor from JSON
  factory RoadCodeCarModelRes.fromJson(Map<String, dynamic> json) {
    return RoadCodeCarModelRes(
      unitId: json['unitId'] ?? '',
      driverId: json['driverId'],
      speed: json['speed'] ?? 0,
      geom: Geometry.fromJson(json['geom'] ?? {}),
      timestamp: json['timestamp'] ?? '',
      roadId: json['roadId'] ?? 0,
      lastUpdatedAt: json['lastUpdatedAt'] ?? '',
      isOnAssignedRoad: json['isOnAssignedRoad'] ?? false,
      distanceFromRoad: (json['distanceFromRoad'] ?? 0).toDouble(),
      lastOnRoadTimestamp: json['lastOnRoadTimestamp'] ?? '',
      plate: json['plate'] ?? '',
      provinceId: json['provinceId'],
      numBodyAlias: json['numBodyAlias'],
      brnDesc: json['brnDesc'] ?? '',
      typeDesc: json['typeDesc'] ?? '',
      typeCode: json['typeCode'] ?? '',
      kindDesc: json['kindDesc'] ?? '',
      kindCode: json['kindCode'] ?? '',
      subKindDescShort: json['subKindDescShort'],
      subKindCode: json['subKindCode'],
      licNo: json['licNo'],
      licEffLocDesc: json['licEffLocDesc'],
      licDesc: json['licDesc'],
      pathDesc: json['pathDesc'],
      subPathName: json['subPathName'],
      wgt: json['wgt'] ?? '',
      wgtTotal: json['wgtTotal'],
      wheelDesc: json['wheelDesc'] ?? '',
      unitIdNum: json['unitIdNum'] ?? '',
      lastRoadChangeDate: json['lastRoadChangeDate'],
      hasOverweightHistory: json['hasOverweightHistory'] ?? false,
      plateProvinceId: json['plateProvinceId'] ?? 0,
      plateNo: json['plateNo'] ?? '',
      road: Road.fromJson(json['road'] ?? {}),
      plateProvince: PlateProvince.fromJson(json['plateProvince'] ?? {}),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'driverId': driverId,
      'speed': speed,
      'geom': geom.toJson(),
      'timestamp': timestamp,
      'roadId': roadId,
      'lastUpdatedAt': lastUpdatedAt,
      'isOnAssignedRoad': isOnAssignedRoad,
      'distanceFromRoad': distanceFromRoad,
      'lastOnRoadTimestamp': lastOnRoadTimestamp,
      'plate': plate,
      'provinceId': provinceId,
      'numBodyAlias': numBodyAlias,
      'brnDesc': brnDesc,
      'typeDesc': typeDesc,
      'typeCode': typeCode,
      'kindDesc': kindDesc,
      'kindCode': kindCode,
      'subKindDescShort': subKindDescShort,
      'subKindCode': subKindCode,
      'licNo': licNo,
      'licEffLocDesc': licEffLocDesc,
      'licDesc': licDesc,
      'pathDesc': pathDesc,
      'subPathName': subPathName,
      'wgt': wgt,
      'wgtTotal': wgtTotal,
      'wheelDesc': wheelDesc,
      'unitIdNum': unitIdNum,
      'lastRoadChangeDate': lastRoadChangeDate,
      'hasOverweightHistory': hasOverweightHistory,
      'plateProvinceId': plateProvinceId,
      'plateNo': plateNo,
      'road': road.toJson(),
      'plateProvince': plateProvince.toJson(),
    };
  }
}

// Geometry
class Geometry {
  String type;
  List<double> coordinates;

  Geometry({required this.type, required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

// Road
class Road {
  int roadId;
  String roadName;

  Road({required this.roadId, required this.roadName});

  factory Road.fromJson(Map<String, dynamic> json) {
    return Road(
      roadId: json['roadId'] ?? 0,
      roadName: json['roadName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roadId': roadId,
      'roadName': roadName,
    };
  }
}

// PlateProvince
class PlateProvince {
  int id;
  String provinceName;

  PlateProvince({required this.id, required this.provinceName});

  factory PlateProvince.fromJson(Map<String, dynamic> json) {
    return PlateProvince(
      id: json['id'] ?? 0,
      provinceName: json['provinceName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provinceName': provinceName,
    };
  }
}
