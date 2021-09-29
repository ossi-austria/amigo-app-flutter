import 'package:amigo_flutter/src/core/dashboard/component/dashboard_button.dart';
import 'package:amigo_flutter/src/core/dashboard/dashboard_provider.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/provider/auth_provider.dart';
import 'package:amigo_flutter/src/service/profile_api_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);

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
          padding: const EdgeInsets.all(25.0),
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

class FamilyFragment extends StatelessWidget {
  const FamilyFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Family');
  }
}

class HistoryFragment extends StatelessWidget {
  const HistoryFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('History');
  }
}

class DashboardFragment extends StatelessWidget {
  const DashboardFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileApiService =
        Provider.of<ProfileApiService>(context, listen: false);
    return FutureBuilder<Response<PersonDto>>(
      future: profileApiService.getOwnProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var response = snapshot.data!;
          if (response.isSuccessful) {
            var personDto = response.body!;
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
                const Text(
                  'Schön dich zu sehen,',
                  style: TextStyle(
                    fontSize: 24,
                    height: 1.33,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  personDto.name,
                  style: const TextStyle(
                      fontFamily: 'DMSerifDisplay', fontSize: 48, height: 1.0),
                ),
                const Spacer(),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    DashboardButton(
                      icon: Icons.phone,
                      label: 'Sprachanruf starten',
                      onPressed: () {},
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
              ],
            );
          }
        }
        if (snapshot.hasError) {
          print('has error');
          print(snapshot.error!);
        }
        return const Center(child: Text('loading'));
      },
    );
  }
}
