import 'package:amigo_flutter/src/core/family/person_overview_screen.dart';
import 'package:amigo_flutter/src/dto/group_dto.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/provider/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
              final analogues = selectedGroup.members.where(
                  (member) => member.memberType == MembershipType.ANALOGUE);
              final members = selectedGroup.members.where(
                  (member) => member.memberType != MembershipType.ANALOGUE);

              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (analogues.isNotEmpty)
                        ...analogues.map((e) => MyCard(e)).toList(),
                      if (analogues.isNotEmpty)
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
    return Card(
      child: InkWell(
        onTap: () {
          final groupProvider =
              Provider.of<GroupProvider>(context, listen: false);
          groupProvider.selectGroupMember(personDto);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PersonOverviewScreen(personDto)));
        },
        child: SizedBox(
          height: 72,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                ),
                child: AspectRatio(
                  aspectRatio: 1.0,
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
                                  'assets/images/figma/family-dummy.png'),
                            ),
                    ),
                  ),
                ),
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
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          height: 1.375,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff00292e),
                        ),
                      ),
                      Text(
                        personDto.memberType.enumToString(),
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.1428,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff00292e),
                        ),
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
        return 'Center Person';
      case MembershipType.OWNER:
      case MembershipType.ADMIN:
        return 'Administrator';
      case MembershipType.MEMBER:
        return 'Familienmitglied';
    }
  }
}
