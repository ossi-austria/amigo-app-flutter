import 'dart:convert';

import 'package:amigoapp/src/dto/login_result_dto.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';

extension AmigoCloudEventExtensions on AmigoCloudEvent {
  String toSecureStorageString() {
    return jsonEncode(this);
  }

  static AmigoCloudEvent? fromSecureStorageString(String string) {
    return AmigoCloudEvent.fromMap(jsonDecode(string));
  }
}
