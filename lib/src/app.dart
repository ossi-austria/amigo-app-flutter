import 'package:amigo_flutter/src/config/themes/default_theme.dart';
import 'package:amigo_flutter/src/core/auth/login/login_screen.dart';
import 'package:amigo_flutter/src/core/auth/register/register_credentials_screen.dart';
import 'package:amigo_flutter/src/core/auth/register/register_photo_screen.dart';
import 'package:amigo_flutter/src/core/auth/register/register_screen.dart';
import 'package:amigo_flutter/src/core/auth/register/register_summary_screen.dart';
import 'package:amigo_flutter/src/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.navigatorKey}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
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
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: DefaultTheme.themeData,
      darkTheme: ThemeData.dark(),
      navigatorKey: navigatorKey,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
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
              default:
                return const RootScreen();
            }
          },
        );
      },
    );
  }
}
