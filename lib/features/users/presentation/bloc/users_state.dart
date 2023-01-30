part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  final List<UserData> usersData;
  final int page;
  const UsersState({this.usersData = const [], this.page = 1});

  @override
  List<Object> get props => [usersData];
}

class UsersInitial extends UsersState {
  const UsersInitial({super.usersData});
}

class UsersLoading extends UsersState {
  const UsersLoading({super.usersData});
}

class UsersLoaded extends UsersState {
  final int totalpages;
  const UsersLoaded(this.totalpages, {super.usersData, super.page});
}

class UsersCreatedState extends UsersState {
  const UsersCreatedState({super.usersData});
}

class UsersFailure extends UsersState {
  final String message;
  const UsersFailure({super.usersData, this.message = ''});

  @override
  List<Object> get props => super.props + [message];
}
