import 'package:amigoapp/src/core/call/call_screen.dart';
import 'package:amigoapp/src/dto/call_token_dto.dart';
import 'package:amigoapp/src/dto/group_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:amigoapp/src/provider/profile_provider.dart';
import 'package:amigoapp/src/service/api/call_api_service.dart';
import 'package:amigoapp/src/service/navigation_service.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'call_provider_test.mocks.dart';

@GenerateMocks([
  GroupProvider,
  CallApiService,
  ProfileProvider,
  NavigationService,
  Tracking
]) //CallApiService, NavigationService, Tracking
void main() {
  late CallProvider subject;

  final tracking = MockTracking();
  final groupProvider = MockGroupProvider();
  final callApiService = MockCallApiService();
  final profileProvider = MockProfileProvider();
  final navigationService = MockNavigationService();

  setUp(() {
    subject =
        CallProvider(groupProvider, profileProvider, callApiService, navigationService, tracking);
    when(groupProvider.getSelectedGroup()).thenAnswer((_) async => groupDto);

    when(navigationService.navigateTo(any)).thenAnswer((_) async => null);
  });

  group('CallProvider', () {
    test('should navigate on success and track event', () async {
      when(callApiService.createCall(any, any))
          .thenAnswer((_) async => Response(http.Response('{}', 200), callTokenDto));

      await subject.startOutgoingCall();

      verify(tracking.logEvent('call_start'));
      verify(navigationService.navigateTo(CallScreen.routeName));
    });

    test('should track error on error ', () async {
      when(callApiService.createCall(any, any))
          .thenAnswer((_) async => Response(http.Response('{}', 400), callTokenDto));

      await subject.startOutgoingCall();

      verify(tracking.logEvent('call_start_error'));
      verifyNever(navigationService.navigateTo(CallScreen.routeName));
    });
  });
}

const groupDto = GroupDto(
    'groupId', 'name', [PersonDto('id', 'name', 'groupId', MembershipType.ANALOGUE, 'avatarUrl')]);

final callTokenDto = CallTokenDto('id', 'senderId', 'receiverId', CallType.VIDEO, null, null,
    CallState.ACCEPTED, null, DateTime.now(), null, null);
