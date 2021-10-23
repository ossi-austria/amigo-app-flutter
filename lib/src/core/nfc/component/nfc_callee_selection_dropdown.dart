import 'package:amigo_flutter/src/component/custom_dropdown_button.dart';
import 'package:amigo_flutter/src/dto/group_dto.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/provider/group_provider.dart';
import 'package:amigo_flutter/src/provider/nfc_provider.dart';
import 'package:flutter/material.dart';

class NfcCallerSelectionDropdown extends StatelessWidget {
  final NfcProvider nfcProvider;
  final GroupProvider groupProvider;

  const NfcCallerSelectionDropdown(this.nfcProvider, this.groupProvider,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GroupDto>(
      future: groupProvider.getSelectedGroup(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final group = snapshot.data!;
          if (group.members.isEmpty) {
            return const Text('Keine Personen in der Gruppe vorhanden');
          } else {
            return CustomDropdownButton<PersonDto>(
              value: nfcProvider.selectedCallee,
              onChanged: (value) => nfcProvider.selectCallee(value),
              items: group.members
                  .where((element) =>
                      element.memberType != MembershipType.ANALOGUE)
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e.name),
                      value: e,
                    ),
                  )
                  .toList(),
            );
          }
        } else {
          // TODO: error handling
        }
        return const Text('loading');
      },
    );
  }
}
