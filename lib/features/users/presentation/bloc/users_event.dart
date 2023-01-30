part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UsersEvent {
  const GetUserEvent({required this.page});
  final int page;
}

class CreateUserEvent extends UsersEvent {
  const CreateUserEvent({required this.user});
  final UserData user;
}
