import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:amigoapp/src/service/api/call_api_service.dart';
import 'package:amigoapp/src/service/navigation_service.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'call_provider_test.mocks.dart';

//MockGroupProvider(), MockCallApiService(), MockNavigationService(), MockTracking()
@GenerateMocks([GroupProvider,CallApiService, NavigationService, Tracking]) //CallApiService, NavigationService, Tracking
void main() {
  group('Plus Operator', () {
    test('Counter value should be incremented', () {
      final groupProvider = MockGroupProvider();
      // final subject = CallProvider(groupProvider);
      //
      // subject.startCall();
      //
      // expect(subject.value, 1);
    });
  });
}
