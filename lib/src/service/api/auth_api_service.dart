import 'package:amigo_flutter/src/dto/login_request.dart';
import 'package:amigo_flutter/src/dto/login_result_dto.dart';
import 'package:amigo_flutter/src/dto/register_request.dart';
import 'package:amigo_flutter/src/dto/secret_account_dto.dart';
import 'package:amigo_flutter/src/dto/set_fcm_token_request.dart';
import 'package:chopper/chopper.dart';

part 'auth_api_service.chopper.dart';

@ChopperApi(baseUrl: '/auth')
abstract class AuthApiService extends ChopperService {
  static AuthApiService create([ChopperClient? client]) =>
      _$AuthApiService(client);

  @Post(path: '/register')
  Future<Response<SecretAccountDto>> register(
      @Body() RegisterRequest registerRequest);

  @Post(path: '/login')
  Future<Response<LoginResultDto>> login(@Body() LoginRequest loginRequest);

  @Post(path: '/fcm-token')
  Future<Response> setFcmTokenRequest(
      @Body() SetFcmTokenRequest setFcmTokenRequest);
}
