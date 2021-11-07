import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_list/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  MockDataConnectionChecker mockInternetConnectionChecker =
      MockDataConnectionChecker();
  NetworkInfoImpl networkInfoImpl =
      NetworkInfoImpl(mockInternetConnectionChecker);

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      // act
      final result = networkInfoImpl.isConnected;
      // assert
      verify(() => (mockInternetConnectionChecker.hasConnection));
      expect(result, tHasConnectionFuture);
    });
  });
}
