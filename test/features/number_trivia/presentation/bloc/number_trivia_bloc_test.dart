import 'package:clean_arch/core/errors/failures.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/core/util/input_converter.dart';
import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

// class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {}
//
// class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}
//
// class MockInputConverter extends Mock implements InputConverter {}

@GenerateMocks([GetConcreteNumberTrivia])
@GenerateMocks([GetRandomNumberTrivia])
@GenerateMocks([InputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  group('GetTriviaForConcreteNumber', () {
    const String tNumberString = '1';
    const int tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    void setUpMockInputConvertedSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async* {
      // arrange
      setUpMockInputConvertedSuccess();
      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      // assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async* {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      // assert later
      final expected = [
        const ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));

      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
    });

    test('should get data from the concrete use case', () async* {
      //arrange
      setUpMockInputConvertedSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
      //act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));
      //assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async* {
      //arrange
      setUpMockInputConvertedSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const LoadedState(trivia: tNumberTrivia),
      ];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
    });

    test('should emit [Loading, Error] when getting data fails', () async* {
      //arrange
      setUpMockInputConvertedSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure(message: '')));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
    });

    test('should emit [Loading, Error] with proper message for the error when getting data fails', () async* {
      //arrange
      setUpMockInputConvertedSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((realInvocation) async => Left(CacheFailure(message: '')));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumberEvent(tNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test('should get data from the random use case', () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
      //act
      bloc.add(GetTriviaForRandomNumberEvent());
      await untilCalled(mockGetRandomNumberTrivia(any));
      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const LoadedState(trivia: tNumberTrivia),
      ];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumberEvent());
    });

    test('should emit [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure(message: '')));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumberEvent());
    });

    test('should emit [Loading, Error] with proper message for the error when getting data fails', () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((realInvocation) async => Left(CacheFailure(message: '')));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        const ErrorState(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumberEvent());
    });
  });
}
