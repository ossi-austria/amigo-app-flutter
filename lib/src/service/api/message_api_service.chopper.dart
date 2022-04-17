// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$MessageApiService extends MessageApiService {
  _$MessageApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MessageApiService;

  @override
  Future<Response<MultiMessageDto>> postMessage(
      String receiverId, String text) {
    final $url = '/messages/';
    final $params = <String, dynamic>{'receiverId': receiverId};
    final $parts = <PartValue>[PartValue<String>('text', text)];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, parameters: $params);
    return client.send<MultiMessageDto, MultiMessageDto>($request);
  }

  @override
  Future<Response<MessageTokenDto>> getMessage(String id) {
    final $url = '/messages/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<MessageTokenDto, MessageTokenDto>($request);
  }

  @override
  Future<Response<List<MessageTokenDto>>> getSentMessages() {
    final $url = '/messages/sent';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<MessageTokenDto>, MessageTokenDto>($request);
  }

  @override
  Future<Response<List<MessageTokenDto>>> getReceivedMessages() {
    final $url = '/messages/received';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<MessageTokenDto>, MessageTokenDto>($request);
  }
}
