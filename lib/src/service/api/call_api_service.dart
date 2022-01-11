import 'package:amigo_flutter/src/dto/call_token_dto.dart';
import 'package:chopper/chopper.dart';

part 'call_api_service.chopper.dart';

@ChopperApi(baseUrl: '/calls')
abstract class CallApiService extends ChopperService {
  static CallApiService create([ChopperClient? client]) =>
      _$CallApiService(client);

  @Post(path: '/')
  Future<Response<CallTokenDto>> createCall(
      @Query() String receiverId, @Query() String callType,
      {String? personId});

  @Get(path: '/{id}')
  Future<Response<CallTokenDto>> getCall(@Path() String id);

  @Patch(path: '/{id}/accept')
  Future<Response<CallTokenDto>> acceptCall(@Path() String id);

  @Patch(path: '/{id}/cancel')
  Future<Response<CallTokenDto>> cancelCall(@Path() String id);

  @Patch(path: '/{id}/deny')
  Future<Response<CallTokenDto>> denyCall(@Path() String id);

  @Patch(path: '/{id}/finish')
  Future<Response<CallTokenDto>> finishCall(@Path() String id);
}
