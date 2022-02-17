import 'package:amigoapp/src/config/themes/default_theme.dart';
import 'package:amigoapp/src/core/family/component/person_image.dart';
import 'package:amigoapp/src/core/nfc/nfc_person_list_screen.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/nfc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonOverviewScreen extends StatelessWidget {
  final PersonDto personDto;

  const PersonOverviewScreen(this.personDto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nfcProvider = Provider.of<NfcProvider>(context, listen: false);
    nfcProvider.getCreatedNfcInfosForPerson(personDto);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zurück zur Übersicht'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PersonImage(personDto),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(personDto.name,
                        style: Theme.of(context).textTheme.headline3),
                    const SizedBox(height: 20),
                    /*const Card(
                      child: ListTile(
                        title: Text(
                          'E-Mail',
                          style: DefaultTheme.labelTextStyle,
                        ),
                        subtitle: Text(
                          'mail.is.missing@dto.amigo',
                          style: DefaultTheme.footnoteTextStyle,
                        ),
                      ),
                    ),*/
                    if (personDto.memberType == MembershipType.ANALOGUE)
                      Card(
                        child: Consumer<NfcProvider>(
                          builder: (_, nfcProvider, __) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        NfcPersonListScreen(personDto),
                                    settings: const RouteSettings(
                                        name: 'NfcPersonListScreen')));
                              },
                              title: const Text(
                                'AMIGO-Karten',
                                style: DefaultTheme.labelTextStyle,
                              ),
                              subtitle: Text(
                                '${nfcProvider.nfcInfoList.length} Karten',
                                style: DefaultTheme.footnoteTextStyle,
                              ),
                              trailing:
                                  const Icon(Icons.arrow_forward_outlined),
                            );
                          },
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Benutzer entfernen',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
