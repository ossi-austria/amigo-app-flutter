// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ProfileApiService extends ProfileApiService {
  _$ProfileApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProfileApiService;

  @override
  Future<Response<PersonDto>> getOwnProfile() {
    final $url = '/profile';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<PersonDto, PersonDto>($request);
  }
}
