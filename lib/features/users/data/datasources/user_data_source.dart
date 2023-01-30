import 'package:dio/dio.dart';
import '../../../../core/services/api_modules/api_response_model.dart';
import '../../../../core/services/api_modules/generic_response_converter.dart';
import '../../domain/repositories/users_repository_usecase.dart';
import '../models/users_model.dart';
import '../repositories/users_repo.dart';

class UsersDataSource extends IUsersRepository {
  final UsersRepository _authRepo = UsersRepository();

  @override
  createUser(Map<String, dynamic> payload) async {
    Response response = await _authRepo.createUser(payload);
    return ApiResponseConverter.genericResponseValidation<UserData>(
        response: response, data: UserData.fromJson(response.data));
  }

  @override
  Future<ResponseModel<UsersModel>> getUsers(int? page) async {
    Response response = await _authRepo.getUser(page ?? 1);
    return ApiResponseConverter.genericResponseValidation<UsersModel>(
        response: response, data: UsersModel.fromJson(response.data));
  }
}
