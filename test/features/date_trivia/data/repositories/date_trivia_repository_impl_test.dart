import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/platform/network_info.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

@GenerateNiceMocks(
    [MockSpec<DateTriviaRemoteDataSource>(), MockSpec<NetworkInfo>()])
import 'date_trivia_repository_impl_test.mocks.dart';

void main() {
  DateTriviaRepositoryImpl repository;
  MockDateTriviaRemoteDataSource mockDateTriviaRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockDateTriviaRemoteDataSource = MockDateTriviaRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = DateTriviaRepositoryImpl(
      remoteDataSource: mockDateTriviaRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
