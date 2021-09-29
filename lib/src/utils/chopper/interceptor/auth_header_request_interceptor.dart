import 'dart:async';
import 'dart:io';

import 'package:amigo_flutter/src/dto/login_result_dto.dart';
import 'package:amigo_flutter/src/service/secure_storage_service.dart';
import 'package:chopper/chopper.dart';

class AuthHeaderRequestInterceptor implements RequestInterceptor {
  AuthHeaderRequestInterceptor(this.secureStorageService);

  final SecureStorageService secureStorageService;

  @override
  FutureOr<Request> onRequest(Request request) async {
    LoginResultDto? loginResultDto =
        await secureStorageService.getSavedLoginResultDTO();

    if (loginResultDto == null) {
      return request;
    } else {
      return applyHeader(request, HttpHeaders.authorizationHeader,
          'Bearer ${loginResultDto.accessToken.token}',
          override: false);
    }
  }
}
