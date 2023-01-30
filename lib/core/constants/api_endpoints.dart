class ApiEnpoints {
  static const String baseUrl = "https://reqres.in/api/";

  static String getUsers({pages = 1}) => 'users?page=$pages';
  static String postUsers = 'users';
}
