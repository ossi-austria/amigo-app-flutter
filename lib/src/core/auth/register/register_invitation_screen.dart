import 'package:amigoapp/src/core/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class RegisterInvitationScreen extends StatelessWidget {
  static const routeName = '/register/invitation';

  const RegisterInvitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: 100),
                Text(
                  'Schön dich zu sehen,',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'Michael',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Container(height: 50),
                Text(
                  'Ich konnte noch keine Einladung zu einer Familiengruppe für dich finden.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Container(height: 25),
                Text(
                  'Bitte den Administrator deiner Familie dir eine Einladung an deine E-Mail Adresse zu schicken.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Container(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const Dashboard()));
                  },
                  child: const Text(
                    'Neue Familiengruppe gründen',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
