import 'dart:io';

import 'package:amigo_flutter/src/provider/auth_provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                const Text(
                  'Geschafft!',
                  style: TextStyle(
                      fontFamily: 'DMSerifDisplay', fontSize: 48, height: 1.0),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Freut mich, dich kennen zu lernen ${widget.summaryArguments.name}!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.33,
                  ),
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 19.0, horizontal: 24.0),
                      child: Text(
                        'Abschließen',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
