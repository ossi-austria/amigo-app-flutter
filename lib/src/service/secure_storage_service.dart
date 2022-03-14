import 'package:amigoapp/src/dto/login_result_dto.dart';
import 'package:amigoapp/src/extension/amigo_cloud_event_extensions.dart';
import 'package:amigoapp/src/extension/login_result_dto_extensions.dart';
import 'package:amigoapp/src/utils/logger.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final log = getLogger();

class SecureStorageService {
  SecureStorageService(this.secureStorage);

  FlutterSecureStorage secureStorage;
  static const String accessTokenStorageName = 'access_token';
  static const String refreshTokenStorageName = 'refresh_token';
  static const String loginResultStorageName = 'login_result';
  static const String policyAccepted = 'policy_accepted';
  static const String dataIntentCloudEvent = 'data_intent_cloud_event';

  Future<LoginResultDto?> getSavedLoginResultDTO() async {
    String? loginResultString = await secureStorage.read(key: loginResultStorageName);
    if (loginResultString == null) {
      return Future.value(null);
    } else {
      return Future.value(LoginResultDtoExtensions.fromSecureStorageString(loginResultString));
    }
  }

  Future<void> setSavedLoginResultDTO(LoginResultDto loginResultDto) async {
    await secureStorage.write(
        key: loginResultStorageName, value: loginResultDto.toSecureStorageString());
  }

  Future<AmigoCloudEvent?> getSavedAmigoCloudEvent() async {
    String? jsonString = await secureStorage.read(key: dataIntentCloudEvent);
    if (jsonString == null) {
      return Future.value(null);
    } else {
      log.i('AmigoCloudEvent jsonString: ' + jsonString);
      return Future.value(AmigoCloudEventExtensions.fromSecureStorageString(jsonString));
    }
  }

  Future<void> saveAmigoCloudEvent(AmigoCloudEvent amigoCloudEvent) async {
    await secureStorage.write(
        key: dataIntentCloudEvent, value: amigoCloudEvent.toSecureStorageString());
    log.i('saveAmigoCloudEvent');
  }

  Future<void> clearAmigoCloudEvent() async {
    await secureStorage.write(key: dataIntentCloudEvent, value: null);
  }

  Future<void> setPolicyAccepted(bool accepted) async {
    await secureStorage.write(key: policyAccepted, value: accepted.toString());
  }

  Future<bool> getPolicyAccepted() async {
    return secureStorage.containsKey(key: loginResultStorageName);
  }

  Future<void> clearEverything() async {
    await secureStorage.deleteAll();
  }
}
