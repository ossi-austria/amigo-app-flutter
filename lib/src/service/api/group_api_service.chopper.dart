// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$GroupApiService extends GroupApiService {
  _$GroupApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GroupApiService;

  @override
  Future<Response<List<GroupDto>>> getMyGroups() {
    final $url = '/groups';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GroupDto>, GroupDto>($request);
  }
}
