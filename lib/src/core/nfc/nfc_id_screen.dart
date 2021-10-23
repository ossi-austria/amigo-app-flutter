import 'package:amigo_flutter/src/component/result_screen.dart';
import 'package:amigo_flutter/src/component/wizard_scaffold.dart';
import 'package:amigo_flutter/src/constants/validators.dart';
import 'package:amigo_flutter/src/provider/group_provider.dart';
import 'package:amigo_flutter/src/provider/nfc_provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NfcIdScreen extends StatelessWidget {
  const NfcIdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WizardScaffold(
      Wrap(
        runSpacing: 20,
        children: [
          Text(
            'ID eingeben',
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            'Gib der Amigo-Karte eine Bezeichnung um den Überblick zu behalten. Scanne anschließend den gewünschten Chip oder gib die aufgedruckte Nummer ein.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Consumer<NfcProvider>(
            builder: (context, nfcProvider, child) {
              final nameTextEditingController =
                  TextEditingController(text: nfcProvider.name ?? '');
              final idTextEditingController =
                  TextEditingController(text: nfcProvider.id ?? '');
              nameTextEditingController.selection = TextSelection(
                  baseOffset: nameTextEditingController.text.length,
                  extentOffset: nameTextEditingController.text.length);
              idTextEditingController.selection = TextSelection(
                  baseOffset: idTextEditingController.text.length,
                  extentOffset: idTextEditingController.text.length);
              return Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Bezeichnung',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                      ),
                      validator: Validators.requiredValidator,
                      onChanged: (value) => nfcProvider.setName(value),
                      controller: nameTextEditingController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'ID',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.nfc),
                          onPressed: () async {
                            await nfcProvider.readNfc();
                            Flushbar(
                              title: 'NFC Scan',
                              message: 'Bitte NFC Tag scannen',
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          },
                        ),
                      ),
                      validator: Validators.requiredValidator,
                      onChanged: (value) => nfcProvider.setId(value),
                      controller: idTextEditingController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: nfcProvider.stepTwoFinished
                            ? () async {
                                try {
                                  await nfcProvider.createNfc();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Consumer<GroupProvider>(
                                      builder: (context, groupProvider,
                                              child) =>
                                          ResultScreen(
                                              'NFC-Chip ist bereit!',
                                              '${groupProvider.selectedGroupMember?.name} kann den Chip jetzt auf ihrer AMIGOBox lesen.',
                                              'Schließen', () {
                                        Navigator.of(context).popUntil(
                                            ModalRoute.withName(
                                                'NfcPersonListScreen'));
                                      }),
                                    ),
                                  ));
                                } on Exception catch (e) {
                                  Flushbar(
                                    title:
                                        'Fehler beim Erstellen der Amigko-Karte',
                                    message: 'Bitte versuchen Sie es erneut.',
                                    duration: const Duration(seconds: 5),
                                  ).show(context);
                                }
                              }
                            : null,
                        child: const Text('Weiter'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      2,
      2,
    );
  }
}
