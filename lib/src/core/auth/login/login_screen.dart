import 'package:amigoapp/src/constants/validators.dart';
import 'package:amigoapp/src/core/dashboard/dashboard.dart';
import 'package:amigoapp/src/provider/auth_provider.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final lang = AppLocalizations.of(context)!;
    final tracking = Provider.of<Tracking>(context);
    tracking.setCurrentScreen('Login');
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
                    lang.login_welcome,
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    lang.login_welcome_text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(height: 50),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: lang.login_form_mail,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                    ),
                    validator: Validators.usernameValidator,
                    controller: _emailController,
                  ),
                  Container(height: 25),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: lang.login_form_password,
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
                      tracking.logEvent('action_login');
                      if (_formKey.currentState!.validate()) {
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        final result = await authProvider.login(
                            _emailController.text, _passwordController.text);
                        if (result == null) {
                          Flushbar(
                            title: lang.login_error_title,
                            message: lang.login_error_message,
                            duration: const Duration(seconds: 5),
                          ).show(context);
                        } else {
                          Navigator.of(context).pushNamed(Dashboard.routeName);
                        }
                      } else {
                        tracking.logEvent('login_invalid');
                      }
                    },
                    child: Text(
                      lang.login_button,
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
