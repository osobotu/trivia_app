import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'date_trivia_remote_data_source_test.mocks.dart';

void main() {
  late DateTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('date_trivia.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = DateTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    'getDateTrivia',
    () {
      const testDay = 04;
      const testMonth = 11;
      final testDateTriviaModel =
          DateTriviaModel.fromJson(json.decode(fixture('date_trivia.json')));

      test(
        'should perform a GET request on a URL with date being the endpoint and with application/json header',
        () {
          setUpMockHttpClientSuccess200();

          dataSource.getDateTrivia(month: testMonth, day: testDay);

          verify(
            mockHttpClient.get(
              Uri.parse(APIConstants.dateEndpoint(testMonth, testDay)),
              headers: APIConstants.headers,
            ),
          );
        },
      );

      test(
        'should return DateTrivia when the response is 200 (success)',
        () async {
          setUpMockHttpClientSuccess200();
          final result =
              await dataSource.getDateTrivia(month: testMonth, day: testDay);

          expect(result, equals(testDateTriviaModel));
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          setUpMockHttpClientFailure404();
          final call = dataSource.getDateTrivia;

          expect(
            () => call(month: testMonth, day: testDay),
            throwsA(isA<ServerException>()),
          );
        },
      );
    },
  );
}
