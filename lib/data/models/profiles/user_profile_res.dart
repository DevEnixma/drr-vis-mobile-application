class UserProfileRes {
  String? username;
  String? groupName;
  String? title;
  String? firstName;
  String? lastName;
  String? email;
  String? stockRequest;
  String? approveRequest;
  String? approveDistribute;
  String? stockOut;
  int? uStatus;
  String? lastUpdate;
  String? cusId;
  int? deptId;
  int? deptGroup;
  int? deptType;
  int? position;
  int? role;
  String? deptName;
  String? deptTypeName;
  String? positionName;
  String? roleName;

  UserProfileRes.empty();

  UserProfileRes({this.username, this.groupName, this.title, this.firstName, this.lastName, this.email, this.stockRequest, this.approveRequest, this.approveDistribute, this.stockOut, this.uStatus, this.lastUpdate, this.cusId, this.deptId, this.deptGroup, this.deptType, this.position, this.role, this.deptName, this.deptTypeName, this.positionName, this.roleName});

  UserProfileRes.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    groupName = json['group_name'];
    title = json['title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    stockRequest = json['stock_request'];
    approveRequest = json['approve_request'];
    approveDistribute = json['approve_distribute'];
    stockOut = json['stock_out'];
    uStatus = json['u_status'];
    lastUpdate = json['last_update'];
    cusId = json['cus_id'];
    deptId = json['dept_id'];
    deptGroup = json['dept_group'];
    deptType = json['dept_type'];
    position = json['position'];
    role = json['role'];
    deptName = json['dept_name'];
    deptTypeName = json['dept_type_name'];
    positionName = json['position_name'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['group_name'] = this.groupName;
    data['title'] = this.title;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['stock_request'] = this.stockRequest;
    data['approve_request'] = this.approveRequest;
    data['approve_distribute'] = this.approveDistribute;
    data['stock_out'] = this.stockOut;
    data['u_status'] = this.uStatus;
    data['last_update'] = this.lastUpdate;
    data['cus_id'] = this.cusId;
    data['dept_id'] = this.deptId;
    data['dept_group'] = this.deptGroup;
    data['dept_type'] = this.deptType;
    data['position'] = this.position;
    data['role'] = this.role;
    data['dept_name'] = this.deptName;
    data['dept_type_name'] = this.deptTypeName;
    data['position_name'] = this.positionName;
    data['role_name'] = this.roleName;
    return data;
  }
}
