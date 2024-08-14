class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://localhost:8000/api/";
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String getAllStudent = "auth/getAllStudents";
  static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  static const String updateStudent = "auth/updateStudent/";
  static const String deleteStudent = "auth/deleteStudent/";
  static const String imageUrl = "http://localhost:8000/products/";
  static const String uploadImage = "auth/uploadImage";
  static const String currentUser = "auth/getMe";
  static const String pagination = "product/pagination";
  static const String photos = "photos";

  static const limitPage = 20;
  // ====================== Batch Routes ======================
  // static const String createBatch = "batch/createBatch";
  // static const String getAllBatch = "batch/getAllBatches";

  // ====================== Course Routes ======================
  // static const String createCourse = "course/createCourse";
  // static const String deleteCourse = "course/";
  // static const String getAllCourse = "course/getAllCourse";
}
