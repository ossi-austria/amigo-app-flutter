import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/profile_provider.dart';
import 'nfc_person_list_widget.dart';

class NfcPersonListFragment extends StatelessWidget {
  const NfcPersonListFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final myProfile = profileProvider.currentProfile;
    return NfcCardsWidget(personDto: myProfile);
  }
}
