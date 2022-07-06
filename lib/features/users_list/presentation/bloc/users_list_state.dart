part of 'users_list_bloc.dart';

abstract class UsersListState extends Equatable {
  const UsersListState();

  @override
  List<Object> get props => [];
}

class EmptyState extends UsersListState {}

class LoadingState extends UsersListState {}

class ErrorState extends UsersListState {
  final String message;

  const ErrorState({required this.message});
}

class DoneState extends UsersListState {
  final UsersListEntity usersList;

  const DoneState({required this.usersList});
}
