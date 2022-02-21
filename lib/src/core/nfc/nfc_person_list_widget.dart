import 'package:amigoapp/src/config/themes/default_theme.dart';
import 'package:amigoapp/src/core/nfc/nfc_choose_function_screen.dart';
import 'package:amigoapp/src/core/nfc/nfc_info_type_extensions.dart';
import 'package:amigoapp/src/dto/nfc_info_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/nfc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NfcCardsWidget extends StatelessWidget {
  const NfcCardsWidget({
    Key? key,
    required this.personDto,
  }) : super(key: key);

  final PersonDto personDto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                              title: Text(
                                e.name,
                                style: DefaultTheme.labelTextStyle,
                              ),
                              subtitle: Text(
                                '${e.type.enumToString()} / NFC-ID: ${e.nfcRef}',
                                style: DefaultTheme.footnoteTextStyle,
                              ),
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
    );
  }
}
