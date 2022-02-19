import 'package:amigoapp/src/service/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var onUserInteraction = AutovalidateMode.disabled;
  bool testAccepted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tracking = Provider.of<Tracking>(context);
    final lang = AppLocalizations.of(context)!;
    tracking.setCurrentScreen('Onboarding');
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Form(
              autovalidateMode: onUserInteraction,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(height: 100),
                  Text(
                    lang.onboarding_welcome,
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  Container(height: 50),

                  Text(
                    lang.onboarding_alpha_explanation,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(height: 30),
                  Center(
                      child: InkWell(
                          child: Text(lang.onboarding_privacy_policy_text),
                          focusColor: Colors.blue,
                          onTap: () =>
                              launch(lang.onboarding_privacy_policy_link))),
                  Container(height: 30),
                  CheckboxListTile(
                    title: Text(lang.onboarding_alpha_check,
                        style: Theme.of(context).textTheme.bodyText1),
                    value: testAccepted,
                    onChanged: (newValue) {
                      setState(() {
                        testAccepted = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (testAccepted) {
                        tracking.logEvent('click_login');
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      }
                    },
                    child: Text(
                      lang.onboarding_alpha_accept,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // For Alpha-Test, we deactivate Register!
                  // TextButton(
                  //   onPressed: () {
                  //     tracking.logEvent('click_register');
                  //     Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  //   },
                  //   child: const Text('Registrieren'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
