import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/profile_provider.dart';
import 'nfc_person_list_widget.dart';

class NfcPersonListFragment extends StatelessWidget {
  const NfcPersonListFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return FutureBuilder<PersonDto>(
        future: profileProvider.getOwnProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NfcCardsWidget(personDto: snapshot.data!);
          }
          if (snapshot.hasError) {
            print('has error');
            print(snapshot.error!);
            const Center(child: Text('Error'));
          }
          return const Center(child: Text('loading'));
        });
  }
}
