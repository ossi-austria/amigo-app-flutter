import 'dart:io';

import 'package:amigo_flutter/src/core/dashboard/dashboard_provider.dart';
import 'package:amigo_flutter/src/dto/account_dto.dart';
import 'package:amigo_flutter/src/dto/login_request.dart';
import 'package:amigo_flutter/src/dto/login_result_dto.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/dto/register_request.dart';
import 'package:amigo_flutter/src/dto/secret_account_dto.dart';
import 'package:amigo_flutter/src/dto/token_result_dto.dart';
import 'package:amigo_flutter/src/provider/auth_provider.dart';
import 'package:amigo_flutter/src/service/auth_api_service.dart';
import 'package:amigo_flutter/src/service/navigation_service.dart';
import 'package:amigo_flutter/src/service/profile_api_service.dart';
import 'package:amigo_flutter/src/service/secure_storage_service.dart';
import 'package:amigo_flutter/src/utils/chopper/interceptor/auth_header_request_interceptor.dart';
import 'package:amigo_flutter/src/utils/chopper/interceptor/auth_header_response_interceptor.dart';
import 'package:amigo_flutter/src/utils/chopper/json_serializable_converter.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secureStorageService =
      SecureStorageService(const FlutterSecureStorage());

  const converter = JsonSerializableConverter({
    PersonDto: PersonDto.fromJson,
    RegisterRequest: RegisterRequest.fromJson,
    SecretAccountDto: SecretAccountDto.fromJson,
    LoginRequest: LoginRequest.fromJson,
    LoginResultDto: LoginResultDto.fromJson,
    TokenResultDto: TokenResultDto.fromJson,
    AccountDto: AccountDto.fromJson,
  });

  final navigatorKey = GlobalKey<NavigatorState>();
  final navigationService = NavigationService(navigatorKey);
  final authRequestInterceptor =
      AuthHeaderRequestInterceptor(secureStorageService);
  final authResponseInterceptor =
      AuthHeaderResponseInterceptor(secureStorageService, navigationService);

  final chopper = ChopperClient(
    client: http.Client(),
    baseUrl: 'http://amigo-dev.ossi-austria.org:8080/v1',
    converter: converter,
    errorConverter: converter,
    services: [
      AuthApiService.create(),
      ProfileApiService.create(),
    ],
    interceptors: [
      (Request request) async => applyHeader(
          request, HttpHeaders.contentTypeHeader, 'application/json'),
      authRequestInterceptor,
      authResponseInterceptor,
    ],
  );

  final authApiService = chopper.getService<AuthApiService>();
  final profileApiService = chopper.getService<ProfileApiService>();

  final authProvider = AuthProvider(secureStorageService, authApiService);
  authProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        Provider(create: (_) => authApiService),
        Provider(create: (_) => profileApiService),
        Provider(create: (_) => secureStorageService),
      ],
      child: MyApp(
        navigatorKey: navigatorKey,
      ),
    ),
  );
}
