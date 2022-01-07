// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CallApiService extends CallApiService {
  _$CallApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CallApiService;

  @override
  Future<Response<CallTokenDto>> createCall(String receiverId, String callType,
      {String? personId}) {
    final $url = '/calls/';
    final $params = <String, dynamic>{
      'receiverId': receiverId,
      'callType': callType
    };
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<CallTokenDto, CallTokenDto>($request);
  }

  @override
  Future<Response<CallTokenDto>> getCall(String id) {
    final $url = '/calls/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<CallTokenDto, CallTokenDto>($request);
  }

  @override
  Future<Response<List<CallTokenDto>>> getSentCalls() {
    final $url = '/calls/sent';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<CallTokenDto>, CallTokenDto>($request);
  }

  @override
  Future<Response<List<CallTokenDto>>> getReceivedCalls() {
    final $url = '/calls/received';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<CallTokenDto>, CallTokenDto>($request);
  }

  @override
  Future<Response<CallTokenDto>> acceptCall(String id) {
    final $url = '/calls/${id}/accept';
    final $request = Request('PATCH', $url, client.baseUrl);
    return client.send<CallTokenDto, CallTokenDto>($request);
  }

  @override
  Future<Response<CallTokenDto>> cancelCall(String id) {
    final $url = '/calls/${id}/cancel';
    final $request = Request('PATCH', $url, client.baseUrl);
    return client.send<CallTokenDto, CallTokenDto>($request);
  }

  @override
  Future<Response<CallTokenDto>> denyCall(String id) {
    final $url = '/calls/${id}/deny';
    final $request = Request('PATCH', $url, client.baseUrl);
    return client.send<CallTokenDto, CallTokenDto>($request);
  }

  @override
  Future<Response<CallTokenDto>> finishCall(String id) {
    final $url = '/calls/${id}/finish';
    final $request = Request('PATCH', $url, client.baseUrl);
    return client.send<CallTokenDto, CallTokenDto>($request);
  }
}
