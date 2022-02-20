import 'package:amigoapp/src/config/themes/default_theme.dart';
import 'package:amigoapp/src/core/family/component/person_image.dart';
import 'package:amigoapp/src/core/family/person_overview_screen.dart';
import 'package:amigoapp/src/dto/group_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FamilyFragment extends StatelessWidget {
  const FamilyFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meine Familie',
          style: Theme.of(context).textTheme.headline2,
        ),
        Container(height: 25),
        FutureBuilder<GroupDto>(
          future: groupProvider.getSelectedGroup(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final selectedGroup = snapshot.data!;
              final analogue = selectedGroup.analogue;
              final members = selectedGroup.digitals;

              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (analogue != null) MyCard(analogue),
                      if (members.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 15),
                          child: Divider(),
                        ),
                      ...members.map((e) => MyCard(e)).toList(),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              // TODO: error handling
              print('has error');
              print(snapshot.error!);
            }
            return const Center(child: Text('loading'));
          },
        )
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final PersonDto personDto;

  const MyCard(this.personDto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    return Card(
      child: InkWell(
        onTap: () {
          groupProvider.selectGroupMember(personDto);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PersonOverviewScreen(personDto)));
        },
        child: SizedBox(
          height: 72,
          child: Row(
            children: [
              PersonImage(
                personDto,
                personImageFormat: PersonImageFormat.rounded,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        personDto.name,
                        style: DefaultTheme.labelTextStyle,
                      ),
                      Text(
                        personDto.memberType.enumToString(),
                        style: DefaultTheme.footnoteTextStyle,
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.arrow_forward_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension MembershipTypeExtensions on MembershipType {
  String enumToString() {
    switch (this) {
      case MembershipType.ANALOGUE:
        return 'Hauptperson';
      case MembershipType.OWNER:
        return 'Gruppenersteller';
      case MembershipType.ADMIN:
        return 'Admin';
      case MembershipType.MEMBER:
        return 'Familienmitglied';
    }
  }
}
