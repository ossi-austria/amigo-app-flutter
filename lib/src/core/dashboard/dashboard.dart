import 'package:amigoapp/src/core/dashboard/component/dashboard_button.dart';
import 'package:amigoapp/src/core/dashboard/dashboard_provider.dart';
import 'package:amigoapp/src/core/family/family_fragment.dart';
import 'package:amigoapp/src/core/history/history_fragment.dart';
import 'package:amigoapp/src/core/nfc/nfc_person_list_fragment.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/auth_provider.dart';
import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:amigoapp/src/provider/profile_provider.dart';
import 'package:amigoapp/src/service/fcm_service.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/group_provider.dart';
import 'dashboard_fragment.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/dashboard';

  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final _fcmService = Provider.of<FCMService>(context, listen: false);
    final tracking = Provider.of<Tracking>(context);
    tracking.setCurrentScreen('Dashboard');
    _fcmService.initFirebase();

    final fragments = [
      const DashboardFragment(),
      const FamilyFragment(),
      const NfcPersonListFragment(),
      const HistoryFragment(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: dashboardProvider.currentIndex,
        onTap: (int index) => dashboardProvider.currentIndex = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
           BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Familie'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'Amigo-Karten'),
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
