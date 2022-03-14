import 'package:amigoapp/src/core/call/call_screen.dart';
import 'package:amigoapp/src/core/dashboard/dashboard.dart';
import 'package:amigoapp/src/dto/call_token_dto.dart';
import 'package:amigoapp/src/dto/group_dto.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:amigoapp/src/provider/profile_provider.dart';
import 'package:amigoapp/src/service/api/call_api_service.dart';
import 'package:amigoapp/src/service/navigation_service.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:amigoapp/src/utils/logger.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class CallProvider with ChangeNotifier {
  final CallApiService _callApiService;
  final GroupProvider _groupProvider;
  final ProfileProvider _profileProvider;
  final NavigationService _navigationService;
  final Tracking _tracking;
  final log = getLogger();

  CallProvider(this._groupProvider, this._profileProvider, this._callApiService,
      this._navigationService, this._tracking);

  CallTokenDto? _currentCall;

  CallTokenDto? get currentCall => _currentCall;

  bool hasCall() {
    return _currentCall != null;
  }

  /// Attention: asserts there is a call.
  Future<bool> isIncomingCall() async {
    final profile = await _profileProvider.getOwnProfile();
    return _currentCall!.receiverId == profile.id;
  }

  /// Attention: asserts there is a call.
  Future<bool> isOutgoingCall() async {
    final profile = await _profileProvider.getOwnProfile();
    return _currentCall!.senderId == profile.id;
  }

  /// Start call ACTIVELY and safe currentCall - wait for opposite to accept
  Future<void> startOutgoingCall() async {
    GroupDto _group = await _groupProvider.getSelectedGroup();
    final analogue = _group.analogue;
    final callResponse = await _callApiService.createCall(analogue!.id, CallType.VIDEO.stringValue);
    if (!callResponse.isSuccessful) {
      _tracking.logEvent('call_start_error');
      log.e('Cannot create call: ' + callResponse.toString());
    } else {
      _tracking.logEvent('call_start');
      _currentCall = callResponse.body!;
      _navigationService.navigateTo(CallScreen.routeName);
    }
  }

  /// accept an incoming Call actively - start Jitsi
  Future<void> acceptIncomingCall() async {
    if (_currentCall == null) {
      return Future.error('_currentCall must not be null.');
    }
    final callResponse = await _callApiService.getCall(_currentCall!.id);
    if (callResponse.isSuccessful) {
      final acceptCallResponse = await _callApiService.acceptCall(_currentCall!.id);
      if (!acceptCallResponse.isSuccessful) {
        _tracking.logEvent('call_accept_error');
        log.e('Cannot accept call: ' + callResponse.toString());
      } else {
        _tracking.logEvent('call_accept');
        _currentCall = acceptCallResponse.body!;
        _startJitsi();
      }
    } else {
      log.e('Cannot fetch call: ' + callResponse.toString());
    }
  }

  Future<void> denyCall() async {
    if (_currentCall != null) {
      _tracking.logEvent('call_deny');
      await _callApiService.denyCall(_currentCall!.id);
    }
    _navigateBack();
  }

  Future<void> cancelCall() async {
    if (_currentCall != null) {
      _tracking.logEvent('call_cancel');
      await _callApiService.cancelCall(_currentCall!.id);
    }
    _navigateBack();
  }

  Future<void> callMessageReceived(AmigoCloudEvent amigoCloudEvent) async {
    _tracking.logEvent('fcm_receive_call');

    // var ownProfile = await _profileProvider.getOwnProfile();
    final callResponse = await _callApiService.getCall(amigoCloudEvent.entityId);
    if (!callResponse.isSuccessful) {
      _tracking.logEvent('incoming_call_error');
      log.e('Cannot handle callMessageReceived: ' + callResponse.toString());
      throw Exception('!callResponse.isSuccessful ');
    }

    log.i('Incoming call:' + callResponse.bodyString);

    if (_currentCall != null) {
      if (_currentCall!.id != callResponse.body!.id) {
        log.w('Incoming call is not matching the current active call!');
        log.w('Decline incoming call to avoid errors!');
        await _callApiService.denyCall(amigoCloudEvent.entityId);
      } else {
        _currentCall = callResponse.body!;
        if (_currentCall!.callState == CallState.ACCEPTED) {
          log.i('Partner accepted, startJitsi!');
          await _startJitsi();
        } else if (_currentCall!.callState == CallState.FINISHED) {
          log.i('FINISHED, closeJitsi!');
          _navigateBack();
        } else if (_currentCall!.callState == CallState.DENIED) {
          log.i('Partner DENIED, closeJitsi!');
          _navigateBack();
        } else if (_currentCall!.callState == CallState.CANCELLED) {
          log.i('CANCELLED, closeJitsi!');
          _navigateBack();
        }
      }
    } else {
      _currentCall = callResponse.body!;
      if (_currentCall!.callState == CallState.CALLING) {
        _tracking.logEvent('incoming_call_retrieved');
        _navigationService.navigateTo(CallScreen.routeName);
      } else {
        throw Exception('State confusion: developer, fix this!');
      }
    }
    notifyListeners();
  }

  void _navigateBack() {
    JitsiMeet.closeMeeting();
    _currentCall = null;
    _navigationService.navigateTo(Dashboard.routeName);

  }

  Future<void> _startJitsi() async {
    final listener = JitsiMeetingListener(
      onConferenceTerminated: (message) async {
        await _callApiService.finishCall(_currentCall!.id);
      },
    );
    final options = JitsiMeetingOptions(room: _currentCall!.id)
      ..serverURL = 'https://amigo-dev.ossi-austria.org'
      ..token = _currentCall!.token;

    log.i('joinMeeting: ' + options.toString());
    JitsiMeet.joinMeeting(options, listener: listener);
  }

// _setGroupProvider(GroupProvider groupProvider) {
//   _groupProvider = groupProvider;
//   notifyListeners();
// }
}
