import 'package:amigo_flutter/src/constants/validators.dart';
import 'package:amigo_flutter/src/core/auth/register/register_credentials_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                  const Text(
                    '\nLos gehts!',
                    style: TextStyle(
                        fontFamily: 'DMSerifDisplay',
                        fontSize: 48,
                        height: 1.0),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Wie darf ich dich nennen?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      height: 1.33,
                    ),
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
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 19.0, horizontal: 24.0),
                        child: Text(
                          'Weiter',
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
      ),
    );
  }
}
