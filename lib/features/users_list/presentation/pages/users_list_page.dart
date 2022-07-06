import 'package:clean_arch/features/users_list/domain/entities/users_list_entity.dart';
import 'package:clean_arch/features/users_list/presentation/bloc/users_list_bloc.dart';
import 'package:clean_arch/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<UsersListBloc> buildBody(context) {
    return BlocProvider(
      create: (context) => sl<UsersListBloc>(),
      child: Container(
        child: BlocBuilder<UsersListBloc, UsersListState>(
          builder: (context, state){
            if(state is LoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is ErrorState){
              return MessageDisplay(message: state.message,);
            } else if(state is DoneState){
              if(state.usersList.results != null){
                return UsersListDisplay(usersList: state.usersList,);
              }
            }
            return const SizedBox.shrink();
          },
        ),
      )
    );
  }
}

class UsersListDisplay extends StatefulWidget {
  final UsersListEntity usersList;

  const UsersListDisplay({
    Key? key,
    required this.usersList
  }) : super(key: key);

  @override
  State<UsersListDisplay> createState() => _UsersListDisplayState();
}

class _UsersListDisplayState extends State<UsersListDisplay> {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int pageCount = 1;

  Future<void> _onRefresh() async {
    context
        .read<UsersListBloc>()
        .add(UsersListLoadingEvent(1, 20));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          controller: scrollController,
          itemCount: widget.usersList.results!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => FavoriteCheckCubit(),
                        child: UserInfo(
                          user: users[index],
                        ),
                      ),
                    ),
                  );*/
                },
                child: Container(
                  color: Colors.blue.withOpacity(0.5),
                  child: ListTile(
                    leading: Hero(
                      tag: '$index',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.usersList.results![index].picture!.medium,
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          '${widget.usersList.results![index].name!.first} ${widget.usersList.results![index].name!.last}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Text(
          message,
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        )),
    );
  }
}
