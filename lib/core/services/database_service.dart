abstract class DatabaseService {
  Future<void> addData({
    String? uid,
    required String path,
    required Map<String, dynamic> data,
  });
  Future<bool> checkIfDataExists({required String path, required String uid});
  Future<Map<String, dynamic>> getData({required String path, String? uid});
  Future<void> deleteUserData({required String path, required String uid});
}
