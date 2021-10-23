import 'package:amigo_flutter/src/dto/change_nfc_info_request.dart';
import 'package:amigo_flutter/src/dto/create_nfc_info_request.dart';
import 'package:amigo_flutter/src/dto/nfc_info_dto.dart';
import 'package:chopper/chopper.dart';

part 'nfc_info_api_service.chopper.dart';

@ChopperApi(baseUrl: '/nfcs')
abstract class NfcInfoApiService extends ChopperService {
  static NfcInfoApiService create([ChopperClient? client]) =>
      _$NfcInfoApiService(client);

  @Post(path: '/')
  Future<Response<NfcInfoDto>> createNfcInfo(
      @Body() CreateNfcInfoRequest createNfcInfoRequest);

  @Patch(path: '/{id}')
  Future<Response<NfcInfoDto>> changeNfcInfo(
      @Path() String id, @Body() ChangeNfcInfoRequest changeNfcInfoRequest);

  @Get(path: '/own')
  Future<Response<List<NfcInfoDto>>> getOwnNfcInfos({@Header('Amigo-Person-Id') String? personId});

  @Get(path: '/created')
  Future<Response<List<NfcInfoDto>>> getCreatedNfcInfos({@Header('Amigo-Person-Id') String? personId});
}
