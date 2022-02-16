import 'dart:io';

import 'package:amigoapp/src/core/dashboard/dashboard_provider.dart';
import 'package:amigoapp/src/dto/account_dto.dart';
import 'package:amigoapp/src/dto/album_dto.dart';
import 'package:amigoapp/src/dto/call_token_dto.dart';
import 'package:amigoapp/src/dto/change_nfc_info_request.dart';
import 'package:amigoapp/src/dto/create_nfc_info_request.dart';
import 'package:amigoapp/src/dto/group_dto.dart';
import 'package:amigoapp/src/dto/login_request.dart';
import 'package:amigoapp/src/dto/login_result_dto.dart';
import 'package:amigoapp/src/dto/multimedia_dto.dart';
import 'package:amigoapp/src/dto/nfc_info_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/dto/register_request.dart';
import 'package:amigoapp/src/dto/secret_account_dto.dart';
import 'package:amigoapp/src/dto/set_fcm_token_request.dart';
import 'package:amigoapp/src/dto/token_result_dto.dart';
import 'package:amigoapp/src/provider/album_provider.dart';
import 'package:amigoapp/src/provider/auth_provider.dart';
import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:amigoapp/src/provider/history_provider.dart';
import 'package:amigoapp/src/provider/nfc_provider.dart';
import 'package:amigoapp/src/provider/profile_provider.dart';
import 'package:amigoapp/src/service/api/album_api_service.dart';
import 'package:amigoapp/src/service/api/auth_api_service.dart';
import 'package:amigoapp/src/service/api/call_api_service.dart';
import 'package:amigoapp/src/service/api/group_api_service.dart';
import 'package:amigoapp/src/service/api/nfc_info_api_service.dart';
import 'package:amigoapp/src/service/api/profile_api_service.dart';
import 'package:amigoapp/src/service/fcm_service.dart';
import 'package:amigoapp/src/service/navigation_service.dart';
import 'package:amigoapp/src/service/secure_storage_service.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:amigoapp/src/utils/chopper/interceptor/auth_header_request_interceptor.dart';
import 'package:amigoapp/src/utils/chopper/interceptor/auth_header_response_interceptor.dart';
import 'package:amigoapp/src/utils/chopper/json_serializable_converter.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';
import 'package:chopper/chopper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  await initializeFirebase();

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
    GroupDto: GroupDto.fromJson,
    AlbumDto: AlbumDto.fromJson,
    MultimediaDto: MultimediaDto.fromJson,
    NfcInfoDto: NfcInfoDto.fromJson,
    CreateNfcInfoRequest: CreateNfcInfoRequest.fromJson,
    ChangeNfcInfoRequest: ChangeNfcInfoRequest.fromJson,
    SetFcmTokenRequest: SetFcmTokenRequest.fromJson,
    CallTokenDto: CallTokenDto.fromJson,
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
      GroupApiService.create(),
      AlbumApiService.create(),
      NfcInfoApiService.create(),
      CallApiService.create(),
    ],
    interceptors: [
      (Request request) async => applyHeader(
          request, HttpHeaders.contentTypeHeader, 'application/json'),
      authRequestInterceptor,
      authResponseInterceptor,
    ],
  );

  final tracking = Tracking();

  final authApiService = chopper.getService<AuthApiService>();
  final profileApiService = chopper.getService<ProfileApiService>();
  final groupApiService = chopper.getService<GroupApiService>();
  final albumApiService = chopper.getService<AlbumApiService>();
  final nfcInfoApiService = chopper.getService<NfcInfoApiService>();
  final callApiService = chopper.getService<CallApiService>();

  final albumProvider = AlbumProvider(albumApiService);
  final groupProvider = GroupProvider(groupApiService);
  groupProvider.refreshSelectedGroup();

  final historyProvider = HistoryProvider(callApiService);
  final profileProvider = ProfileProvider(profileApiService);
  final callProvider =
      CallProvider(groupProvider, callApiService, navigationService, tracking);
  final sendableMessageHandler = SendableMessageHandler(callProvider);
  final fcmService = FCMService(authApiService, sendableMessageHandler);
  final authProvider =
      AuthProvider(secureStorageService, authApiService, tracking);
  authProvider.init();

  /*
  Future.delayed(
      Duration(seconds: 1),
      () => sendableMessageHandler.handleMessage({
            'type': 'call',
            'action': 'sent',
            'entity_id': '76240cdd-e9bc-4226-9beb-89be6a9653f7',
            'receiver_id': '2fcf0225-bdaa-452a-bc28-436657390168'
          }));*/

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => albumProvider),
        ChangeNotifierProvider(create: (_) => groupProvider),
        ChangeNotifierProvider(create: (_) => profileProvider),
        ChangeNotifierProvider(create: (_) => historyProvider),
        ChangeNotifierProvider(create: (_) => callProvider),
        ChangeNotifierProxyProvider<GroupProvider, CallProvider>(
          update: (context, groupProvider, callProvider) {
            return callProvider!;
          },
          create: (_) => callProvider,
        ),
        ChangeNotifierProxyProvider2<ProfileProvider, GroupProvider,
            NfcProvider>(
          update: (context, profileProvider, groupProvider, nfcProvider) =>
              NfcProvider(profileProvider, groupProvider, nfcInfoApiService),
          create: (_) =>
              NfcProvider(profileProvider, groupProvider, nfcInfoApiService),
        ),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        Provider(create: (_) => authApiService),
        Provider(create: (_) => profileApiService),
        Provider(create: (_) => groupApiService),
        Provider(create: (_) => secureStorageService),
        Provider(create: (_) => nfcInfoApiService),
        Provider(create: (_) => fcmService),
        Provider(create: (_) => tracking),
      ],
      child: MyApp(
        navigatorKey: navigatorKey,
      ),
    ),
  );
}

Future<FirebaseApp> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    Logger.root.log(Level.INFO, 'Firebase init for Android');
    return await Firebase.initializeApp();
  } else if (Platform.isIOS) {
    Logger.root.log(Level.INFO, 'Firebase init for iOS');
    return await Firebase.initializeApp();
  } else {
    Logger.root.log(Level.INFO, 'Firebase init for Web');
    return await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCD3ObsIkXis4ZOxNPWFTvRV5qbDNwd_Kg',
          authDomain: 'amigo-amigobox.firebaseapp.com',
          projectId: 'amigo-amigobox',
          storageBucket: 'amigo-amigobox.appspot.com',
          messagingSenderId: '648045764166',
          appId: '1:648045764166:web:314ff0d30287bbde0eb447',
          measurementId: 'G-ZK6RP093CM'),
    );
  }
}
