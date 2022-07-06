import 'package:clean_arch/core/errors/failures.dart';
import 'package:clean_arch/features/users_list/domain/entities/users_list_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UsersListRepository {
  Future<Either<Failure, UsersListEntity>>? getUsersList(int? page, int? results);
}