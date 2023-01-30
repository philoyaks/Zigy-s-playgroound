import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/services/api_modules/api_interceptor.dart';
import '../../domain/usecases/users_usecases.dart';

class UsersRepository extends IUsersUsecases {
  final BackendService _api = BackendService(Dio());

  @override
  getUser(int page) async {
    try {
      return await _api.dio.get(ApiEnpoints.getUsers(pages: page));
    } on DioError catch (e) {
      return _api.handleError(e);
    }
  }

  @override
  createUser(Map<String, dynamic> payload) async {
    try {
      return await _api.dio.post(
        ApiEnpoints.postUsers,
        data: payload,
      );
    } on DioError catch (e) {
      return _api.handleError(e);
    }
  }
}
