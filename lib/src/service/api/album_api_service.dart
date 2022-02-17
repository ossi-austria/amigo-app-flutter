import 'package:amigoapp/src/dto/album_dto.dart';
import 'package:chopper/chopper.dart';

part 'album_api_service.chopper.dart';

@ChopperApi(baseUrl: '/albums')
abstract class AlbumApiService extends ChopperService {
  static AlbumApiService create([ChopperClient? client]) =>
      _$AlbumApiService(client);

  @Get(path: '/own')
  Future<Response<List<AlbumDto>>> getOwnAlbums();
}
