import 'dart:convert';

import 'package:amigoapp/src/dto/login_result_dto.dart';

extension LoginResultDtoExtensions on LoginResultDto {
  String toSecureStorageString() {
    return jsonEncode(this);
  }

  static LoginResultDto? fromSecureStorageString(String string) {
    return LoginResultDto.fromJson(jsonDecode(string));
  }
}
