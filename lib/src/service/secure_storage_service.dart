import 'package:amigo_flutter/src/dto/login_result_dto.dart';
import 'package:amigo_flutter/src/extension/login_result_dto_extensions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService(this.secureStorage);

  FlutterSecureStorage secureStorage;
  static const String accessTokenStorageName = 'access_token';
  static const String refreshTokenStorageName = 'refresh_token';
  static const String loginResultStorageName = 'login_result';

  void readToken() async {
    await secureStorage.read(key: accessTokenStorageName);
    await secureStorage.read(key: refreshTokenStorageName);
  }

  Future<LoginResultDto?> getSavedLoginResultDTO() async {
    String? loginResultString =
        await secureStorage.read(key: loginResultStorageName);
    if (loginResultString == null) {
      return Future.value(null);
    } else {
      return Future.value(LoginRresultDtoExtensionsons.fromSecureStorageString(
          loginResultString));
    }
  }

  Future<void> setSavedLoginResultDTO(LoginResultDto loginResultDto) async {
    await secureStorage.write(
        key: loginResultStorageName,
        value: loginResultDto.toSecureStorageString());
  }

  Future<void> deleteAllToken() async {
    await secureStorage.deleteAll();
  }
}
