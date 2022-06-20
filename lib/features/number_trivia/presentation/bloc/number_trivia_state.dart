part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class InitialNumberTriviaInitialState extends NumberTriviaState {}

class EmptyState extends NumberTriviaState {}

class LoadingState extends NumberTriviaState {}

class LoadedState extends NumberTriviaState {
  final NumberTrivia trivia;

  const LoadedState({required this.trivia});
}

class ErrorState extends NumberTriviaState{
  final NumberTrivia message;

  const ErrorState({required this.message});
}
