import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/users_bloc.dart';
import '../widgets/modal_creation_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              isScrollControlled: true,
              builder: (context) {
                return ModalCreationWidget();
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Zigy App'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<UsersBloc, UsersState>(listener: (context, state) {
            if (state is UsersFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is UsersCreatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User was created Successfully'),
                ),
              );
            }
          }, builder: (context, state) {
            debugPrint(state.usersData.length.toString());
            return state.usersData.isEmpty
                ? Container()
                : Expanded(
                    child: ListView.builder(
                    itemBuilder: (context, idx) => ListTile(
                      title: Text(
                          '${state.usersData[idx].firstName} ${state.usersData[idx].lastName!}'),
                      subtitle: Text('${state.usersData[idx].email}'),
                      leading: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        height: 60,
                        width: 60,
                        child: ClipOval(
                          child: Image.network(
                            state.usersData[idx].avatar!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                    itemCount: state.usersData.length,
                  ));
          }),
          BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
            if (state is UsersInitial || state is UsersLoading) {
              return const CircularProgressIndicator();
            } else if (state is UsersLoaded) {
              int mveToNextPage = state.page;
              return mveToNextPage++ > state.totalpages
                  ? const SizedBox()
                  : ElevatedButton(
                      onPressed: () {
                        context
                            .read<UsersBloc>()
                            .add(GetUserEvent(page: mveToNextPage++));
                      },
                      child: const Text('Load More'));
            } else {
              return const SizedBox();
            }
          }),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
