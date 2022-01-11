import 'package:amigo_flutter/src/dto/group_dto.dart';
import 'package:chopper/chopper.dart';

part 'group_api_service.chopper.dart';

@ChopperApi(baseUrl: '/groups')
abstract class GroupApiService extends ChopperService {
  static GroupApiService create([ChopperClient? client]) =>
      _$GroupApiService(client);

  @Get(path: '')
  Future<Response<List<GroupDto>>> getMyGroups();
}
