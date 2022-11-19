import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(
    () {
      mockInternetConnectionChecker = MockInternetConnectionChecker();
      networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
    },
  );

  group(
    'isConnected',
    () {
      test(
        'should forward the call to InternetConnectionChecker.hasConnection ',
        () {
          final testHasConnectionFuture = Future.value(true);

          when(mockInternetConnectionChecker.hasConnection)
              .thenAnswer((_) => testHasConnectionFuture);

          final result = networkInfo.isConnected;

          verify(mockInternetConnectionChecker.hasConnection);

          expect(result, testHasConnectionFuture);
        },
      );
    },
  );
}
