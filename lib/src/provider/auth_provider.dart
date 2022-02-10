import 'package:amigo_flutter/src/dto/login_request.dart';
import 'package:amigo_flutter/src/dto/login_result_dto.dart';
import 'package:amigo_flutter/src/dto/register_request.dart';
import 'package:amigo_flutter/src/dto/secret_account_dto.dart';
import 'package:amigo_flutter/src/service/api/auth_api_service.dart';
import 'package:amigo_flutter/src/service/secure_storage_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

enum AuthState { initial, registered, loggedIn }

class AuthProvider with ChangeNotifier {
  AuthProvider(this.secureStorageService, this.authApiService);

  final SecureStorageService secureStorageService;
  final AuthApiService authApiService;

  AuthState _authState = AuthState.initial;

  AuthState get authState => _authState;

  void init() async {
    final savedLoginResultDTO =
        await secureStorageService.getSavedLoginResultDTO();
    if (savedLoginResultDTO != null) {
      _authState = AuthState.loggedIn;
    }
  }

  Future<SecretAccountDto?> register(
      String email, String password, String name) async {
    Response<SecretAccountDto> registerResponse =
        await authApiService.register(RegisterRequest(email, password, name));
    if (registerResponse.isSuccessful) {
      // TODO: when invitations are implemented in backend, show invitationscreen instead
      await login(email, password);
      return Future.value(registerResponse.body);
    } else {
      chopperLogger.warning("Cannot register: ${registerResponse.statusCode} -> ${registerResponse.bodyString}");
    }
    return Future.value(null);
  }

  Future<LoginResultDto?> login(String email, String password) async {
    Response<LoginResultDto> loginResponse =
        await authApiService.login(LoginRequest(email, password));
    if (loginResponse.isSuccessful) {
      secureStorageService.setSavedLoginResultDTO(loginResponse.body!);
      _authState = AuthState.loggedIn;
      notifyListeners();
      return Future.value(loginResponse.body);
    }
    return Future.value(null);
  }

  Future<void> logout() async {
    secureStorageService.deleteAllToken();
    _authState = AuthState.initial;
    notifyListeners();
  }
}
