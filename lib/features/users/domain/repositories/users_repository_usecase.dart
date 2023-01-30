import '../../../../core/services/api_modules/api_response_model.dart';
import '../../data/models/users_model.dart';

abstract class IUsersRepository {
  //[POST] request
  Future<ResponseModel<UserData>> createUser(Map<String, dynamic> payload);

  //[POST] request
  Future<ResponseModel<UsersModel>> getUsers(int? page);
}
