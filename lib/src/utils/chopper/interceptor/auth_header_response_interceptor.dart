import 'dart:async';

import 'package:amigo_flutter/src/core/auth/login/login_screen.dart';
import 'package:amigo_flutter/src/service/navigation_service.dart';
import 'package:amigo_flutter/src/service/secure_storage_service.dart';
import 'package:chopper/chopper.dart';

class AuthHeaderResponseInterceptor implements ResponseInterceptor {
  AuthHeaderResponseInterceptor(
      this.secureStorageService, this.navigationService);

  final SecureStorageService secureStorageService;
  final NavigationService navigationService;

  @override
  FutureOr<Response> onResponse(Response<dynamic> response) {
    if ((response.statusCode == 401 || response.statusCode == 403) &&
        !response.base.request!.url.toString().contains('/login')) {
      secureStorageService.deleteAllToken();
      navigationService.navigateTo(
        LoginScreen.routeName,
        removeAllRoutes: true,
      );
    }
    return response;
  }
}
