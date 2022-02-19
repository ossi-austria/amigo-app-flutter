import 'package:amigoapp/src/core/auth/login/login_screen.dart';
import 'package:amigoapp/src/core/auth/login/onboarding_screen.dart';
import 'package:amigoapp/src/core/auth/register/register_invitation_screen.dart';
import 'package:amigoapp/src/core/dashboard/dashboard.dart';
import 'package:amigoapp/src/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  static const String routingName = '/';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      Widget widgetToShow = Scaffold(
        body: Container(color: Theme.of(context).primaryColor),
      );

      switch (authProvider.authState) {
        case AuthState.initial:
          widgetToShow = const OnboardingScreen();
          break;
        case AuthState.registered:
          widgetToShow = const RegisterInvitationScreen();
          break;
        case AuthState.loggedIn:
          widgetToShow = const Dashboard();
          break;
      }

      return widgetToShow;
    });
  }
}
