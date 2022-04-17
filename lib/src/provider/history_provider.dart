import 'package:amigoapp/src/dto/call_token_dto.dart';
import 'package:amigoapp/src/dto/group_dto.dart';
import 'package:amigoapp/src/dto/message_token_dto.dart';
import 'package:amigoapp/src/service/api/call_api_service.dart';
import 'package:amigoapp/src/service/api/message_api_service.dart';
import 'package:flutter/material.dart';

import 'group_provider.dart';

class HistoryProvider extends ChangeNotifier {
  final CallApiService _callApiService;
  final MessageApiService _messageApiService;
  final GroupProvider _groupProvider;

  HistoryProvider(this._callApiService, this._messageApiService, this._groupProvider);

  List<CallTokenDto> _sentCalls = [];
  List<CallTokenDto> _receivedCalls = [];
  List<MessageTokenDto> _sentMessages = [];
  List<MessageTokenDto> _receivedMessages = [];
  String? _enteredText;

  List<CallTokenDto> get sentCalls => _sentCalls;

  List<CallTokenDto> get receivedCalls => _receivedCalls;

  List<MessageTokenDto> get sentMessages => _sentMessages;

  List<MessageTokenDto> get receivedMessages => _receivedMessages;

  String? get enteredText => _enteredText;

  void refresh() async {
    _sentCalls = await getSentCalls();
    _receivedCalls = await getReceivedCalls();
    _sentMessages = await getSentMessages();
    _receivedMessages = await getReceivedMessages();

    notifyListeners();
  }

  Future<List<CallTokenDto>> getSentCalls() async {
    final response = await _callApiService.getSentCalls();
    if (!response.isSuccessful) {
      // TODO: throw exception and handle it
      return [];
    }
    return response.body!;
  }

  Future<List<CallTokenDto>> getReceivedCalls() async {
    final response = await _callApiService.getReceivedCalls();
    if (!response.isSuccessful) {
      // TODO: throw exception and handle it
      return [];
    }
    return response.body!;
  }

  Future<List<MessageTokenDto>> getSentMessages() async {
    final response = await _messageApiService.getSentMessages();
    if (!response.isSuccessful) {
      // TODO: throw exception and handle it
      return [];
    }
    return response.body!;
  }

  Future<List<MessageTokenDto>> getReceivedMessages() async {
    final response = await _messageApiService.getReceivedMessages();
    if (!response.isSuccessful) {
      // TODO: throw exception and handle it
      return [];
    }
    return response.body!;
  }

  void setEnteredText(String? text) async {
    _enteredText = text;
  }

  Future<void> sendMessage() async {
    if (_enteredText != null && _enteredText!.isNotEmpty) {
      GroupDto _group = await _groupProvider.getSelectedGroup();
      final analogue = _group.analogue;
      final response = await _messageApiService.postMessage(analogue!.id , _enteredText!);
      if (!response.isSuccessful) {
        // TODO: throw exception and handle it
        return;
      }
      _enteredText = null;
      refresh();
    }
  }
}
