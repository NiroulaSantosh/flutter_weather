import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/core/platform/network_info.dart';
import 'package:mockito/annotations.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late MockConnectivity mockConnectivity;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(mockConnectivity);
  });

  group('should call the helper function to check the network connectivity',
      () {
    test('', () async {
      final tHasConnection = Future.value(true);
      final result = networkInfoImpl.isConnected;
      expect(result, equals(tHasConnection));
    });
  });
}
