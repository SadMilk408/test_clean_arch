import 'package:clean_arch/core/errors/failures.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/users_list/domain/entities/users_list_entity.dart';
import 'package:clean_arch/features/users_list/domain/repositories/users_list_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUsersList implements UseCase<UsersListEntity, Params?> {
  final UsersListRepository repository;

  GetUsersList(this.repository);

  @override
  Future<Either<Failure, UsersListEntity>?> call(Params? params) async {
    return await repository.getUsersList(params?.page, params?.results);
  }
}

class Params extends Equatable {
  final int? page;
  final int? results;

  const Params({required this.page, required this.results});

  @override
  List<Object?> get props => [page, results];
}