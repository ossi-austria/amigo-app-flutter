import 'package:amigoapp/src/dto/login_request.dart';
import 'package:amigoapp/src/dto/login_result_dto.dart';
import 'package:amigoapp/src/dto/register_request.dart';
import 'package:amigoapp/src/dto/secret_account_dto.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:amigoapp/src/service/api/auth_api_service.dart';
import 'package:amigoapp/src/service/secure_storage_service.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

import '../utils/logger.dart';

enum AuthState { initial, registered, loggedIn }

class AuthProvider with ChangeNotifier {
  AuthProvider(this.secureStorageService, this.authApiService,this.groupProvider,this._tracking);

  final SecureStorageService secureStorageService;
  final AuthApiService authApiService;
  final GroupProvider groupProvider;
  final Tracking _tracking;

  final log = getLogger();

  AuthState _authState = AuthState.initial;

  AuthState get authState => _authState;

  void init() async {
    final savedLoginResultDTO =
        await secureStorageService.getSavedLoginResultDTO();
    if (savedLoginResultDTO != null) {
      _authState = AuthState.loggedIn;
      _tracking.logEventVariant('auth_init', 'logged_in');
    } else {
      _tracking.logEventVariant('auth_init', 'not_logged_in');
    }
  }

  Future<SecretAccountDto?> register(
      String email, String password, String name) async {
    _tracking.logEvent('register');

    Response<SecretAccountDto> registerResponse =
        await authApiService.register(RegisterRequest(email, password, name));
    if (registerResponse.isSuccessful) {
      _tracking.logEvent('register_success');
      log.i('register with email: $email');
      await login(email, password);
      return Future.value(registerResponse.body);
    } else {
      log.w('register with email failed: $email');
      _tracking.logEventVariant('register_failed', registerResponse.bodyString);
      chopperLogger.warning('Cannot register: ${registerResponse.statusCode} -> ${registerResponse.bodyString}');
    }
    return Future.value(null);
  }

  Future<LoginResultDto?> login(String email, String password) async {
    _tracking.logEvent('login');

    Response<LoginResultDto> loginResponse =
        await authApiService.login(LoginRequest(email, password));
    if (loginResponse.isSuccessful) {
      log.i('login with email: $email');

      _tracking.logEvent('login_success');

      secureStorageService.setSavedLoginResultDTO(loginResponse.body!);
      _authState = AuthState.loggedIn;
      groupProvider.refreshSelectedGroup();

      notifyListeners();
      return Future.value(loginResponse.body);
    } else {
      log.w('login with email failed: $email');
      _tracking.logEventVariant('login_failed', loginResponse.bodyString);
    }
    return Future.value(null);
  }

  Future<void> logout() async {
    secureStorageService.clearEverything();
    _authState = AuthState.initial;
    notifyListeners();
  }
}
