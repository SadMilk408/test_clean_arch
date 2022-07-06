part of 'users_list_bloc.dart';

abstract class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  List<Object?> get props => [];
}

class UsersListLoadingEvent extends UsersListEvent {
  final int page;
  final int results;

  const UsersListLoadingEvent(this.page, this.results);
}
