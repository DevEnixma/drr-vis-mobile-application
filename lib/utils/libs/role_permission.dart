class RolePermission {
  // static List<int> roleViewer = [1, 99];
  static List<int> roleViewer = [1, 0, 99];

  static bool checkRoleViewer(int? data) {
    // if (data != null && roleViewer.contains(data)) {
    //   return false;
    // }
    return true;
  }

  static bool checkRole1(int? data) {
    // if (data != null && data == 1) {
    // if (data != null && roleViewer.contains(data)) {
    //   return false;
    // }
    return true;
  }
}
