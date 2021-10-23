import 'package:amigo_flutter/src/core/nfc/nfc_choose_function_screen.dart';
import 'package:amigo_flutter/src/dto/nfc_info_dto.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/provider/nfc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runSpacing: 20,
                  children: [
                    Text(
                      'AMIGO-Karten',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      'AMIGO-Karten helfen Emma dabei verschiedene Funktionen auszuführen. Wie z.B Anrufe ausführen oder Fotos aufrufen.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Consumer<NfcProvider>(
                      builder: (_, nfcProvider, __) => Column(
                        children: nfcProvider.nfcInfoList
                            .map(
                              (e) => Card(
                                child: ListTile(
                                  title: Text(e.name),
                                  subtitle: Text(
                                      '${e.type.enumToString()} / NFC-ID: ${e.nfcRef}'),
                                  /*trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {},
                                  ),*/
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => NfcChooseFunctionScreen(personDto),
                        )),
                        child: const Text('Neuen Chip anlegen'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension NfcInfoTypeExtensions on NfcInfoType {
  String enumToString() {
    switch (this) {
      case NfcInfoType.OPEN_ALBUM:
        return 'Album';
      case NfcInfoType.UNDEFINED:
        return 'Keine Aktion';
      case NfcInfoType.CALL_PERSON:
        return 'Anruf';
      case NfcInfoType.SYSTEM:
        return 'System';
      case NfcInfoType.LOGIN:
        return 'Login';
    }
  }
}
