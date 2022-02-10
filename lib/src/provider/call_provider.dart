import 'package:amigoapp/src/core/call/call_screen.dart';
import 'package:amigoapp/src/dto/call_token_dto.dart';
import 'package:amigoapp/src/dto/group_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:amigoapp/src/service/api/call_api_service.dart';
import 'package:amigoapp/src/service/navigation_service.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class CallProvider with ChangeNotifier {
  final CallApiService _callApiService;
  GroupProvider _groupProvider;
  final NavigationService _navigationService;

  CallProvider(
      this._groupProvider, this._callApiService, this._navigationService);

  CallTokenDto? _currentCall;

  CallTokenDto? get currentCall => _currentCall;

  Future<void> startCall() async {
    GroupDto _group = await _groupProvider.getSelectedGroup();
    final analogue = _group.analogue;
    final callResponse = await _callApiService.createCall(
        analogue!.id, CallType.VIDEO.stringValue);
    if (!callResponse.isSuccessful) {
      // TODO: throw exception and handle it
    }
    _currentCall = callResponse.body!;
    _navigationService.navigateTo(CallScreen.routeName);
  }

  Future<void> cancelCall() async {
    if (_currentCall != null) {
      final callResponse = await _callApiService.cancelCall(_currentCall!.id);
      _currentCall = null;
      JitsiMeet.closeMeeting();
    }
    _navigationService.navigateBack();
  }

  Future<void> callMessageReceived(AmigoCloudEvent amigoCloudEvent) async {
    final callResponse =
        await _callApiService.getCall(amigoCloudEvent.entityId);
    if (!callResponse.isSuccessful) {
      // TODO: throw exception and handle it
    }
    _currentCall = callResponse.body!;
    if (_currentCall != null && _currentCall!.callState == CallState.ACCEPTED) {
      final listener = JitsiMeetingListener(
        onConferenceTerminated: (message) async {
          await _callApiService.finishCall(_currentCall!.id);
        },
      );
      final options = JitsiMeetingOptions(room: _currentCall!.id)
        ..serverURL = 'https://amigo-dev.ossi-austria.org'
        ..token = _currentCall!.token;
      JitsiMeet.joinMeeting(options, listener: listener);
    } else if (_currentCall != null &&
        _currentCall!.callState == CallState.FINISHED) {
      JitsiMeet.closeMeeting();
    }
    notifyListeners();
  }

  Future<PersonDto?> getAnalogue() async {
    GroupDto _group = await _groupProvider.getSelectedGroup();
    final analogue = _group.analogue;
    return analogue;
  }

  setGroupProvider(GroupProvider groupProvider) {
    _groupProvider = groupProvider;
    notifyListeners();
  }
}
