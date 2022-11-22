import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';

import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'number_trivia_remote_data_source_test.mocks.dart';

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('trivia.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (realInvocation) async => http.Response('Something went wrong', 404),
    );
  }

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    'getConcreteNumberTrivia',
    () {
      const testNumber = 1;
      final testNumberTriviaModel =
          NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

      test(
        '''should perform a GET request on a URL with number being the endpoint 
        and with application/json header ''',
        () {
          setUpMockHttpClientSuccess200();

          dataSource.getConcreteNumberTrivia(testNumber);

          verify(
            mockHttpClient.get(
              Uri.parse(APIConstants.numberEndpoint(testNumber)),
              headers: APIConstants.headers,
            ),
          );
        },
      );

      test(
        'should return NumberTrivia when the response is 200 (success)',
        () async {
          setUpMockHttpClientSuccess200();
          final result = await dataSource.getConcreteNumberTrivia(testNumber);

          expect(result, equals(testNumberTriviaModel));
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          setUpMockHttpClientFailure404();
          final call = dataSource.getConcreteNumberTrivia;

          expect(() => call(testNumber), throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'getRandomNumberTrivia',
    () {
      const testNumber = 1;
      final testNumberTriviaModel =
          NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

      test(
        '''should perform a GET request on a URL with number being the endpoint 
        and with application/json header ''',
        () {
          setUpMockHttpClientSuccess200();

          dataSource.getRandomNumberTrivia();

          verify(
            mockHttpClient.get(
              Uri.parse(APIConstants.randomNumberEndpoint),
              headers: APIConstants.headers,
            ),
          );
        },
      );

      test(
        'should return NumberTrivia when the response is 200 (success)',
        () async {
          setUpMockHttpClientSuccess200();
          final result = await dataSource.getRandomNumberTrivia();

          expect(result, equals(testNumberTriviaModel));
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          setUpMockHttpClientFailure404();
          final call = dataSource.getRandomNumberTrivia;

          expect(
            () => call(),
            throwsA(isA<ServerException>()),
          );
        },
      );
    },
  );
}
