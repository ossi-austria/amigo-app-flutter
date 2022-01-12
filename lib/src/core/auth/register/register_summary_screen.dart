import 'dart:io';

import 'package:amigo_flutter/src/provider/auth_provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterSummaryArguments {
  final String name;
  final String email;
  final String password;
  final File? profileImage;

  RegisterSummaryArguments(
      this.name, this.email, this.password, this.profileImage);
}

class RegisterSummaryScreen extends StatefulWidget {
  static const routeName = '/register/summary';

  final RegisterSummaryArguments summaryArguments;

  const RegisterSummaryScreen({Key? key, required this.summaryArguments})
      : super(key: key);

  @override
  State<RegisterSummaryScreen> createState() => _RegisterSummaryScreenState();
}

class _RegisterSummaryScreenState extends State<RegisterSummaryScreen> {
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
                Container(height: 150),
                CircleAvatar(
                  child: ClipOval(
                    child: widget.summaryArguments.profileImage != null
                        ? Image.file(widget.summaryArguments.profileImage!)
                        : Image.asset('assets/images/figma/image-light.png'),
                  ),
                  radius: 90,
                ),
                Container(height: 25),
                Text(
                  'Geschafft!',
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Freut mich, dich kennen zu lernen ${widget.summaryArguments.name}!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Container(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      final registerResult = await authProvider.register(
                        widget.summaryArguments.email,
                        widget.summaryArguments.password,
                        widget.summaryArguments.name,
                      );
                      if (registerResult == null) {
                        Flushbar(
                          title: 'Fehler bei der Registrierung',
                          message: 'Bitte versuchen sie es erneut.',
                          duration: const Duration(seconds: 5),
                        ).show(context);
                      }
                    },
                    child: const Text(
                      'Abschließen',
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
