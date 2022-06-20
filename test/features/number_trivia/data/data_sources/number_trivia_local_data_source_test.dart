import 'dart:convert';

import 'package:clean_arch/core/errors/exceptions.dart';
import 'package:clean_arch/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
], customMocks: [
  MockSpec<SharedPreferences>(
      as: #MockSharedPreferencesForTest, returnNullOnMissingStub: true),
])
void main() {
  late NumberTriviaLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture('trivia_cached.json')));

    test(
        'should return NumberTrivia from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));
      // act
      final result = await dataSource.getLastNumberTrivia();
      // assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: 1);

    test('should call SharedPreferences to cache the data', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      final expectedJsonString = jsonEncode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expectedJsonString));
    });
  });
}
