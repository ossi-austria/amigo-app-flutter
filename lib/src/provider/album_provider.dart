import 'package:amigo_flutter/src/dto/album_dto.dart';
import 'package:amigo_flutter/src/service/album_api_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

class AlbumProvider with ChangeNotifier {
  final AlbumApiService _albumApiService;

  AlbumProvider(this._albumApiService);

  Future<Response<List<AlbumDto>>> getOwnAlbums() async {
    return await _albumApiService.getOwnAlbums();
  }
}
