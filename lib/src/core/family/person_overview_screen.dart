import 'package:amigo_flutter/src/core/nfc/nfc_person_list_screen.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/provider/nfc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonOverviewScreen extends StatelessWidget {
  final PersonDto personDto;

  const PersonOverviewScreen(this.personDto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nfcProvider = Provider.of<NfcProvider>(context, listen: false);
    nfcProvider.getCreatedNfcInfosForPerson(personDto);
    const footNoteTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Karla',
      fontSize: 14,
      height: 1.14285,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zurück zur Übersicht'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRect(
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: personDto.avatarUrl != null
                          ? DecorationImage(
                              fit: BoxFit.fitWidth,
                              alignment: FractionalOffset.topCenter,
                              image: NetworkImage(personDto.avatarUrl!))
                          : const DecorationImage(
                              fit: BoxFit.fitWidth,
                              alignment: FractionalOffset.topCenter,
                              image: AssetImage(
                                  'assets/images/figma/person-overview-dummy.png'),
                            ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(personDto.name,
                        style: Theme.of(context).textTheme.headline3),
                    const SizedBox(height: 20),
                    const Card(
                      child: ListTile(
                        title: Text(
                          'E-Mail',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.375,
                          ),
                        ),
                        subtitle: Text(
                          'mail.is.missing@dto.amigo',
                          style: footNoteTextStyle,
                        ),
                      ),
                    ),
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
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  height: 1.375,
                                ),
                              ),
                              subtitle: Text(
                                '${nfcProvider.nfcInfoList.length} Karten',
                                style: footNoteTextStyle,
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
