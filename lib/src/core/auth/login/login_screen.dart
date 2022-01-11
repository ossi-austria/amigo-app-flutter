import 'package:amigo_flutter/src/constants/validators.dart';
import 'package:amigo_flutter/src/core/auth/register/register_screen.dart';
import 'package:amigo_flutter/src/provider/auth_provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var onUserInteraction = AutovalidateMode.disabled;
  bool obscurePassword = true;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    'Herzlich Willkommen',
                    style: TextStyle(
                        fontFamily: 'DMSerifDisplay',
                        fontSize: 48,
                        height: 1.0),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Deine Familie freut sich \nüber Nachrichten von dir!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      height: 1.33,
                    ),
                  ),
                  Container(height: 50),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'E-Mail Adresse',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                    ),
                    validator: Validators.usernameValidator,
                    controller: _emailController,
                  ),
                  Container(height: 25),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Passwort',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => obscurePassword = !obscurePassword),
                        icon: Icon(
                            obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black),
                      ),
                    ),
                    obscureText: obscurePassword,
                    validator: Validators.requiredValidator,
                    controller: _passwordController,
                  ),
                  Container(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      onUserInteraction = AutovalidateMode.onUserInteraction;

                      if (_formKey.currentState!.validate()) {
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        final result = await authProvider.login(
                            _emailController.text, _passwordController.text);
                        if (result == null) {
                          Flushbar(
                            title: 'Fehler bei der Anmeldung',
                            message: 'Bitte versuchen sie es erneut.',
                            duration: const Duration(seconds: 5),
                          ).show(context);
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 19.0, horizontal: 24.0),
                      child: Text(
                        'Einloggen',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: const Text('Registrieren'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
