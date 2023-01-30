import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/services/api_modules/api_response_model.dart';
import '../../data/models/users_model.dart';
import '../../domain/repositories/users_repository_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this.repo) : super(const UsersInitial()) {
    on<CreateUserEvent>(_onCreateUser);
    on<GetUserEvent>(_onGetAllUsers);
  }

  final IUsersRepository repo;

  FutureOr<void> _onCreateUser(
    CreateUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoading(usersData: state.usersData));
    await repo.createUser(event.user.toJson()).then((value) {
      try {
        if (value.error == null) {
          List<UserData> data = [value.data!];
          data.addAll(state.usersData);
          emit(UsersCreatedState(
            usersData: data,
          ));
        } else {
          emit(UsersFailure(
              usersData: state.usersData,
              message: value.error != null
                  ? value.error!.message
                  : 'User was not Created Successfully'));
        }
      } catch (e) {
        if (e is ErrorModel) {
          emit(UsersFailure(message: e.message));
        } else {
          emit(UsersFailure(message: e.toString()));
        }
      }
    });
  }

  FutureOr<void> _onGetAllUsers(
    GetUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoading(usersData: state.usersData));
    await repo.getUsers(event.page).then((value) {
      try {
        if (value.error == null) {
          UsersModel res = value.data!;
          if (event.page != 1) {
            List<UserData> data = [...state.usersData];
            data.addAll(value.data!.data!);
            emit(
                UsersLoaded(res.totalPages!, usersData: data, page: res.page!));
          } else {
            emit(UsersLoaded(res.totalPages!, usersData: res.data!));
          }
        } else if (value.error != null) {
          emit(UsersFailure(
              usersData: state.usersData, message: value.error!.message!));
        } else {
          emit(UsersFailure(
              usersData: state.usersData,
              message: 'Error Occurred while fetching Users'));
        }
      } catch (e) {
        if (e is ErrorModel) {
          emit(UsersFailure(message: e.message));
        } else {
          emit(const UsersFailure(
              message: 'An Error Occurred Please Try again Later'));
        }
      }
    });
  }
}
