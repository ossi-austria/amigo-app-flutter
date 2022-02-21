import 'package:amigoapp/src/config/themes/default_theme.dart';
import 'package:amigoapp/src/core/nfc/nfc_choose_function_screen.dart';
import 'package:amigoapp/src/dto/nfc_info_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/nfc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension NfcInfoTypeExtensions on NfcInfoType {
  String enumToString() {
    switch (this) {
      case NfcInfoType.OPEN_ALBUM:
        return 'Album';
      case NfcInfoType.UNDEFINED:
        return 'Keine Aktion';
      case NfcInfoType.CALL_PERSON:
        return 'Anruf';
      case NfcInfoType.SYSTEM:
        return 'System';
      case NfcInfoType.LOGIN:
        return 'Login';
    }
  }
}
