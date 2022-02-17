// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nfc_info_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$NfcInfoApiService extends NfcInfoApiService {
  _$NfcInfoApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NfcInfoApiService;

  @override
  Future<Response<NfcInfoDto>> createNfcInfo(
      CreateNfcInfoRequest createNfcInfoRequest) {
    final $url = '/nfcs/';
    final $body = createNfcInfoRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<NfcInfoDto, NfcInfoDto>($request);
  }

  @override
  Future<Response<NfcInfoDto>> changeNfcInfo(
      String id, ChangeNfcInfoRequest changeNfcInfoRequest) {
    final $url = '/nfcs/${id}';
    final $body = changeNfcInfoRequest;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<NfcInfoDto, NfcInfoDto>($request);
  }

  @override
  Future<Response<List<NfcInfoDto>>> getOwnNfcInfos({String? personId}) {
    final $url = '/nfcs/own';
    final $headers = {
      if (personId != null) 'Amigo-Person-Id': personId,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<List<NfcInfoDto>, NfcInfoDto>($request);
  }

  @override
  Future<Response<List<NfcInfoDto>>> getCreatedNfcInfos({String? personId}) {
    final $url = '/nfcs/created';
    final $headers = {
      if (personId != null) 'Amigo-Person-Id': personId,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<List<NfcInfoDto>, NfcInfoDto>($request);
  }
}
