abstract class ArrestRepo {
  Future<dynamic> getInfoWeightArretSport(Map<String, dynamic>? query);
  Future<dynamic> getReportArrest(String tdId, Map<String, dynamic>? query);
  Future<dynamic> postArrestLogs(String body);
  Future<dynamic> putArrestLogs(String tdId, body);
  Future<dynamic> getArrestLogsShow(String arrestId);

  // เพิ่มใหม่: method สำหรับดึง PDF URL
  String getArrestLogsPdfUrl(String arrestId);
}
