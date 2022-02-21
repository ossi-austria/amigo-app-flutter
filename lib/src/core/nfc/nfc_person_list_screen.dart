import 'package:amigoapp/src/config/themes/default_theme.dart';
import 'package:amigoapp/src/core/nfc/nfc_choose_function_screen.dart';
import 'package:amigoapp/src/core/nfc/nfc_info_type_extensions.dart';
import 'package:amigoapp/src/dto/nfc_info_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/nfc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nfc_person_list_widget.dart';

class NfcPersonListScreen extends StatelessWidget {
  final PersonDto personDto;

  const NfcPersonListScreen(this.personDto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zurück'),
      ),
      body: SafeArea(
        child: NfcCardsWidget(personDto: personDto),
      ),
    );
  }
}
