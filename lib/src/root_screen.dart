import 'package:amigoapp/src/core/auth/login/onboarding_screen.dart';
import 'package:amigoapp/src/core/auth/register/register_invitation_screen.dart';
import 'package:amigoapp/src/core/dashboard/dashboard.dart';
import 'package:amigoapp/src/provider/auth_provider.dart';
import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:amigoapp/src/service/secure_storage_service.dart';
import 'package:amigoapp/src/utils/logger.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  static const String routingName = '/';

  @override
  Widget build(BuildContext context) {
    final log = getLogger();
    final authProvider = Provider.of<AuthProvider>(context);
    final secureStorageService = Provider.of<SecureStorageService>(context);
    final callProvider = Provider.of<CallProvider>(context);

    return FutureBuilder<AmigoCloudEvent?>(
        future: secureStorageService.getSavedAmigoCloudEvent(),
        builder: (context, snapshot) {

          if (snapshot.hasData && snapshot.data != null) {
            final cloudEvent = snapshot.data!;
            log.i('RootScreen getSaved AmigoCloudEvent() == ' + cloudEvent.toString());
            secureStorageService.clearAmigoCloudEvent();
            callProvider.callMessageReceived(cloudEvent);
          } else {
            log.i('RootScreen getSaved AmigoCloudEvent() == ' + snapshot.data.toString());
          }

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
