import 'package:amigo_flutter/src/component/custom_dropdown_button.dart';
import 'package:amigo_flutter/src/component/wizard_scaffold.dart';
import 'package:amigo_flutter/src/core/nfc/component/nfc_album_selection_dropdown.dart';
import 'package:amigo_flutter/src/core/nfc/component/nfc_callee_selection_dropdown.dart';
import 'package:amigo_flutter/src/core/nfc/nfc_id_screen.dart';
import 'package:amigo_flutter/src/dto/nfc_info_dto.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/provider/album_provider.dart';
import 'package:amigo_flutter/src/provider/group_provider.dart';
import 'package:amigo_flutter/src/provider/nfc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NfcDropDownOption {
  final String description;
  final NfcInfoType nfcInfoType;

  NfcDropDownOption(this.description, this.nfcInfoType);
}

final nfcDropDownOptions = [
  NfcDropDownOption('Anruf starten', NfcInfoType.CALL_PERSON),
  NfcDropDownOption('Fotoalbum öffnen', NfcInfoType.OPEN_ALBUM),
];

class NfcChooseFunctionScreen extends StatelessWidget {
  final PersonDto personDto;

  const NfcChooseFunctionScreen(this.personDto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nfcProvider = Provider.of<NfcProvider>(context, listen: false);
    nfcProvider.resetNewNfcInfo();
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    return WizardScaffold(
      Wrap(
        runSpacing: 20,
        children: [
          Text(
            'Funktion wählen',
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            'Eine AMIGO-Karte kann unterschiedliche Funktionen auf der AMIGOBox ausführen. Bitte wähle eine gewünschte Funktion aus der Liste aus.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Consumer<NfcProvider>(
            builder: (context, nfcProvider, child) {
              return Wrap(
                runSpacing: 20,
                children: [
                  CustomDropdownButton<NfcInfoType>(
                    value: nfcProvider.newNfcTag,
                    onChanged: (value) => nfcProvider.selectNfcInfoType(value),
                    items: nfcDropDownOptions
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e.description),
                            value: e.nfcInfoType,
                          ),
                        )
                        .toList(),
                  ),
                  if (nfcProvider.newNfcTag == NfcInfoType.OPEN_ALBUM)
                    NfcAlbumSelectionDropdown(nfcProvider, albumProvider),
                  if (nfcProvider.newNfcTag == NfcInfoType.CALL_PERSON)
                    NfcCallerSelectionDropdown(nfcProvider, groupProvider),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: nfcProvider.stepOneFinished
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const NfcIdScreen(),
                                ),
                              );
                            }
                          : null,
                      child: const Text('Weiter'),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      1,
      2,
    );
  }
}
