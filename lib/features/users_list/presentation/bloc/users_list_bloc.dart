import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/errors/failures.dart';
import 'package:clean_arch/features/users_list/domain/entities/users_list_entity.dart';
import 'package:clean_arch/features/users_list/domain/usecases/get_users_list.dart';
import 'package:equatable/equatable.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  late GetUsersList getUsersList;

  UsersListBloc({
    required this.getUsersList,
  }) : super(EmptyState()) {
    on<UsersListLoadingEvent>((event, emit) async {
      final failureOrSuccess =
          await getUsersList(Params(page: event.page, results: event.results));
      failureOrSuccess?.fold(
          (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
          (r) => emit(DoneState(usersList: r)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
