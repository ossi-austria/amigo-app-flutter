import 'package:amigo_flutter/src/core/dashboard/component/dashboard_button.dart';
import 'package:amigo_flutter/src/core/dashboard/dashboard_provider.dart';
import 'package:amigo_flutter/src/core/family/family_fragment.dart';
import 'package:amigo_flutter/src/core/history/history_fragment.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/provider/auth_provider.dart';
import 'package:amigo_flutter/src/provider/call_provider.dart';
import 'package:amigo_flutter/src/provider/profile_provider.dart';
import 'package:amigo_flutter/src/service/fcm_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final _fcmService = Provider.of<FCMService>(context, listen: false);

    _fcmService.initFirebase();

    final fragments = [
      const DashboardFragment(),
      const MediaFragment(),
      const FamilyFragment(),
      const HistoryFragment(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: dashboardProvider.currentIndex,
        onTap: (int index) => dashboardProvider.currentIndex = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.image_outlined), label: 'Medien'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Familie'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Verlauf'),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: fragments[dashboardProvider.currentIndex],
        ),
      ),
    );
  }
}

class MediaFragment extends StatelessWidget {
  const MediaFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Medien');
  }
}

class DashboardFragment extends StatelessWidget {
  const DashboardFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
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
                        final callProvider =
                            Provider.of<CallProvider>(context, listen: false);
                        callProvider.startCall();
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
