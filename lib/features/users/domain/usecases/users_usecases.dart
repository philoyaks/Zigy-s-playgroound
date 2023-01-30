abstract class IUsersUsecases {
  //[POST] request
  createUser(Map<String, dynamic> payload);

  //[GET] request
  getUser(int page);
}
