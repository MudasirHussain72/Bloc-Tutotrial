part of 'users_cubit.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

final class UsersLoadingState extends UsersState {}

final class UsersLoadedState extends UsersState {
  final List<UsersModel> usersModel;

  const UsersLoadedState(this.usersModel);
  @override
  List<Object> get props => [usersModel];
}

final class UsersErrorsState extends UsersState {
  final String errorMsg;

  const UsersErrorsState(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
