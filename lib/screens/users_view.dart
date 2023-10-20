import 'package:bloc_tutorial/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    context.read<UsersCubit>().onLoadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users List')),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UsersLoadedState) {
            return ListView.builder(
              itemCount: state.usersModel.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.usersModel[index].name),
                  subtitle: Text(state.usersModel[index].email),
                );
              },
            );
          } else if (state is UsersErrorsState) {
            return Center(child: Text(state.errorMsg));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
