import 'package:amigo_flutter/src/core/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                const Text(
                  'Schön dich zu sehen,',
                  style: TextStyle(
                    fontSize: 24,
                    height: 1.33,
                  ),
                ),
                Container(
                  height: 10,
                ),
                const Text(
                  'Michael',
                  style: TextStyle(
                      fontFamily: 'DMSerifDisplay', fontSize: 48, height: 1.0),
                ),
                Container(height: 50),
                const Text(
                  'Ich konnte noch keine Einladung zu einer Familiengruppe für dich finden.',
                  style: TextStyle(fontSize: 18),
                ),
                Container(height: 25),
                const Text(
                  'Bitte den Administrator deiner Familie dir eine Einladung an deine E-Mail Adresse zu schicken.',
                  style: TextStyle(fontSize: 18),
                ),
                Container(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const Dashboard()));
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 19.0, horizontal: 24.0),
                    child: Text(
                      'Neue Familiengruppe gründen',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
