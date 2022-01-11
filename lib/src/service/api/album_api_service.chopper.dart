// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AlbumApiService extends AlbumApiService {
  _$AlbumApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AlbumApiService;

  @override
  Future<Response<List<AlbumDto>>> getOwnAlbums() {
    final $url = '/albums/own';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<AlbumDto>, AlbumDto>($request);
  }
}
