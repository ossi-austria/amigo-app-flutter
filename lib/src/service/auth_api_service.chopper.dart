// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AuthApiService extends AuthApiService {
  _$AuthApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthApiService;

  @override
  Future<Response<SecretAccountDto>> register(RegisterRequest registerRequest) {
    final $url = '/auth/register';
    final $body = registerRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SecretAccountDto, SecretAccountDto>($request);
  }

  @override
  Future<Response<LoginResultDto>> login(LoginRequest loginRequest) {
    final $url = '/auth/login';
    final $body = loginRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginResultDto, LoginResultDto>($request);
  }
}
