import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  static final requiredValidator =
      RequiredValidator(errorText: 'Dieses Feld ist erforderlich.');
  static final emailValidator =
      EmailValidator(errorText: 'Bitte eine gültige E-Mail eingeben.');

  static final usernameValidator =
      MultiValidator([Validators.requiredValidator, Validators.emailValidator]);

  static final passwordValidator = MultiValidator([
    Validators.requiredValidator,
    MinLengthValidator(4,
        errorText: 'Passwort muss mindestens 4 Zeichen lang sein.')
  ]);
}
