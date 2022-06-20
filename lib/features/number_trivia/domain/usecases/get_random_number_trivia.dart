import 'package:clean_arch/core/errors/failures.dart';
import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>?> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}