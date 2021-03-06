import 'dart:convert';

import 'package:amigo_flutter/src/dto/login_result_dto.dart';

extension LoginRresultDtoExtensionsons on LoginResultDto {
  String toSecureStorageString() {
    return jsonEncode(this);
  }

  static LoginResultDto? fromSecureStorageString(String string) {
    return LoginResultDto.fromJson(jsonDecode(string));
  }
}
