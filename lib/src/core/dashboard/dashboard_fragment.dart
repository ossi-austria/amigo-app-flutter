import 'package:amigoapp/src/core/dashboard/component/dashboard_button.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/auth_provider.dart';
import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:amigoapp/src/provider/profile_provider.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/group_provider.dart';

class DashboardFragment extends StatelessWidget {
  const DashboardFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final tracking = Provider.of<Tracking>(context);
    tracking.setCurrentScreen('Dashboard');

    groupProvider.refreshSelectedGroup();
    profileProvider.fetchOwnProfile();

    return FutureBuilder<PersonDto>(
      future: profileProvider.getOwnProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final personDto = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    authProvider.logout();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Ausloggen',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Text(
                'Schön dich zu sehen,',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(
                height: 10,
              ),
              Text(personDto.name,
                  style: Theme.of(context).textTheme.headline2),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    DashboardButton(
                      icon: Icons.phone,
                      label: 'Sprachanruf starten',
                      onPressed: () {
                        tracking.logEvent('click_videocall');
                        final callProvider =
                            Provider.of<CallProvider>(context, listen: false);
                        callProvider.startOutgoingCall();
                      },
                    ),
                    DashboardButton(
                      icon: Icons.video_call,
                      label: 'Videoanruf starten',
                      onPressed: () {},
                    ),
                    DashboardButton(
                      icon: Icons.image,
                      label: 'Foto schicken',
                      onPressed: () {},
                    ),
                    DashboardButton(
                      icon: Icons.mail,
                      label: 'Textnachricht senden',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (snapshot.hasError) {
          // TODO: error handling
          print('has error');
          print(snapshot.error!);
        }
        return const Center(child: Text('loading'));
      },
    );
  }
}
