import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:chopper/chopper.dart';

part 'profile_api_service.chopper.dart';

@ChopperApi(baseUrl: '/profile')
abstract class ProfileApiService extends ChopperService {
  static ProfileApiService create([ChopperClient? client]) =>
      _$ProfileApiService(client);

  @Get(path: '')
  Future<Response<PersonDto>> getOwnProfile();
}
