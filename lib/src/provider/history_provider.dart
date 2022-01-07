import 'package:amigo_flutter/src/dto/call_token_dto.dart';
import 'package:amigo_flutter/src/service/api/call_api_service.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
  final CallApiService _callApiService;

  HistoryProvider(this._callApiService);

  List<CallTokenDto> _sentCalls = [];
  List<CallTokenDto> _receivedCalls = [];

  List<CallTokenDto> get sentCalls => _sentCalls;

  List<CallTokenDto> get receivedCalls => _receivedCalls;

  void refresh() async {
    _sentCalls = await getSentCalls();
    _receivedCalls = await getReceivedCalls();

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
}
