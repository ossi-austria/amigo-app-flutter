import 'package:amigoapp/src/dto/set_fcm_token_request.dart';
import 'package:amigoapp/src/service/api/auth_api_service.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

class FCMService {
  final AuthApiService _authApiService;
  final SendableMessageHandler _sendableMessageHandler;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FCMService(this._authApiService, this._sendableMessageHandler);

  void initFirebase() async {
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.onTokenRefresh.listen(_tokenListener);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _sendableMessageHandler.handleMessage(message.data);
    });
  }

  void _tokenListener(String? token) async {
    if (token != null) {
      Logger.root.info('New FCM token is: ' + token);
      _authApiService.setFcmTokenRequest(SetFcmTokenRequest(token));
    } else {
      Logger.root.info('New FCM token is null ');
    }
  }
}
