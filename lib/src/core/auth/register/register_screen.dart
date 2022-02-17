import 'package:amigoapp/src/constants/validators.dart';
import 'package:amigoapp/src/core/auth/register/register_credentials_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _onUserInteraction = AutovalidateMode.disabled;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: '');
    _lastNameController = TextEditingController(text: '');
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
              width: (MediaQuery.of(context).size.width / 3),
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
              autovalidateMode: _onUserInteraction,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(height: 25),
                  Text(
                    '\nLos gehts!',
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Wie darf ich dich nennen?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Container(height: 50),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Vorname',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                    ),
                    validator: Validators.requiredValidator,
                    controller: _firstNameController,
                  ),
                  Container(height: 25),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nachname',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                    ),
                    validator: Validators.requiredValidator,
                    controller: _lastNameController,
                  ),
                  Container(height: 50),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _onUserInteraction = AutovalidateMode.onUserInteraction;

                        if (_formKey.currentState!.validate()) {
                          String _name =
                              '${_firstNameController.text} ${_lastNameController.text}';
                          Navigator.of(context).pushNamed(
                              RegisterCredentialsScreen.routeName,
                              arguments: RegisterCredentialsArguments(_name));
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
