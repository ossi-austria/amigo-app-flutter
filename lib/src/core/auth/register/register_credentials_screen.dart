import 'package:amigo_flutter/src/constants/validators.dart';
import 'package:amigo_flutter/src/core/auth/register/register_photo_screen.dart';
import 'package:amigo_flutter/src/core/auth/register/register_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterCredentialsArguments {
  final String name;

  RegisterCredentialsArguments(this.name);
}

class RegisterCredentialsScreen extends StatefulWidget {
  static const routeName = '/register/credentials';

  final String name;

  const RegisterCredentialsScreen({Key? key, required this.name})
      : super(key: key);

  @override
  State<RegisterCredentialsScreen> createState() =>
      _RegisterCredentialsScreenState();
}

class _RegisterCredentialsScreenState extends State<RegisterCredentialsScreen> {
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
      appBar: AppBar(
        title: const Text('Zurück'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 3,
              width: (MediaQuery.of(context).size.width / 3) * 2,
              color: const Color(0xffffba5f),
            ),
          ),
        ),
      ),
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
                  Container(height: 25),
                  Text(
                    'Alles klar, ${widget.name}.',
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Wie möchtest du dich einloggen?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
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
                    validator: Validators.passwordValidator,
                    controller: _passwordController,
                  ),
                  Container(height: 50),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        onUserInteraction = AutovalidateMode.onUserInteraction;

                        if (_formKey.currentState!.validate()) {
                          String _email = _emailController.text;
                          String _password = _passwordController.text;
                          Navigator.of(context)
                              .pushNamed(RegisterPhotoScreen.routeName,
                                  arguments: RegisterSummaryArguments(
                                    widget.name,
                                    _email,
                                    _password,
                                    null,
                                  ));
                        }
                      },
                      child: const Text(
                        'Weiter',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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
