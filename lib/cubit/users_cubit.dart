import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/models/users_model.dart';
import 'package:bloc_tutorial/repo/users_repo.dart';
import 'package:equatable/equatable.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final usersRepo = UsersRepo();
  UsersCubit(UsersRepo usersRepo) : super(UsersLoadingState());
  onLoadUsers() async {
    try {
      emit(UsersLoadingState());
      var usersData = await usersRepo.getUsers();
      emit(UsersLoadedState(usersData));
    } catch (e) {
      emit(UsersErrorsState(e.toString()));
      throw Exception("failed to load users");
    }
  }
}
