class MaterialModelRes {
  int? gid;
  String? goodsName;

  MaterialModelRes.empty();

  MaterialModelRes({this.gid, this.goodsName});

  MaterialModelRes.fromJson(Map<String, dynamic> json) {
    gid = json['gid'];
    goodsName = json['goods_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gid'] = this.gid;
    data['goods_name'] = this.goodsName;
    return data;
  }

  // เพิ่ม method นี้
  @override
  String toString() {
    return goodsName ?? 'ไม่มีชื่อสินค้า';
  }
}
