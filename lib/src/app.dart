import 'package:amigoapp/src/config/themes/default_theme.dart';
import 'package:amigoapp/src/core/auth/login/login_screen.dart';
import 'package:amigoapp/src/core/auth/login/onboarding_screen.dart';
import 'package:amigoapp/src/core/auth/register/register_credentials_screen.dart';
import 'package:amigoapp/src/core/auth/register/register_photo_screen.dart';
import 'package:amigoapp/src/core/auth/register/register_screen.dart';
import 'package:amigoapp/src/core/auth/register/register_summary_screen.dart';
import 'package:amigoapp/src/core/call/call_screen.dart';
import 'package:amigoapp/src/root_screen.dart';
import 'package:amigoapp/src/utils/logger.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The Widget that configures your application.
class AmigoApp extends StatelessWidget {
  final SendableMessageHandler _sendableMessageHandler;

  const AmigoApp(this._sendableMessageHandler,
      {Key? key, required this.navigatorKey})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  // Methods for "piping" from Android intents to Flutter arguments
  static const platform = MethodChannel('amigoapp.channel.shared.data');
  static const Map<Object?, Object?>? argumentsMap = {};

  void loadIntentData() async {
    final log = getLogger();

    log.i('loadIntentData ');
    var argumentsMap = await platform.invokeMethod('amigoCloudEventData');
    log.i('loadIntentData: ' + argumentsMap.toString());
    if (argumentsMap['receiver_id'] != '') {
      final stringArgs = argumentsMap
          .map((key, value) => MapEntry(key.toString(), value.toString()));
      _sendableMessageHandler.handleMessage(Map<String, dynamic>.from(stringArgs));
    }
  }

  @override
  Widget build(BuildContext context) {
    loadIntentData();
    return MaterialApp(
      restorationScopeId: 'app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('de', ''), // Deutsch, no country code
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: DefaultTheme.themeData,
      // darkTheme: ThemeData.dark(),
      navigatorKey: navigatorKey,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case OnboardingScreen.routeName:
                return const OnboardingScreen();
              case LoginScreen.routeName:
                return const LoginScreen();
              case RegisterScreen.routeName:
                return const RegisterScreen();
              case RegisterCredentialsScreen.routeName:
                final args =
                    routeSettings.arguments as RegisterCredentialsArguments;
                return RegisterCredentialsScreen(name: args.name);
              case RegisterPhotoScreen.routeName:
                final args =
                    routeSettings.arguments as RegisterSummaryArguments;
                return RegisterPhotoScreen(summaryArguments: args);
              case RegisterSummaryScreen.routeName:
                final args =
                    routeSettings.arguments as RegisterSummaryArguments;
                return RegisterSummaryScreen(summaryArguments: args);
              case CallScreen.routeName:
                return const CallScreen();
              default:
                return const RootScreen();
            }
          },
        );
      },
    );
  }
}
