import 'package:amigoapp/src/core/dashboard/dashboard_provider.dart';
import 'package:amigoapp/src/core/family/family_fragment.dart';
import 'package:amigoapp/src/core/history/history_fragment.dart';
import 'package:amigoapp/src/core/nfc/nfc_person_list_fragment.dart';
import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:amigoapp/src/service/fcm_service.dart';
import 'package:amigoapp/src/service/secure_storage_service.dart';
import 'package:amigoapp/src/service/tracking.dart';
import 'package:amigoapp/src/utils/logger.dart';
import 'package:amigoapp/src/utils/sendable_message_handler.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_fragment.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/dashboard';

  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final log = getLogger();
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final callProvider = Provider.of<CallProvider>(context);
    final secureStorageService = Provider.of<SecureStorageService>(context);
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

    return FutureBuilder<AmigoCloudEvent?>(
        future: secureStorageService.getSavedAmigoCloudEvent(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final cloudEvent = snapshot.data!;
            log.i('dash getSaved AmigoCloudEvent() == ' + cloudEvent.toString());
            secureStorageService.clearAmigoCloudEvent();
            callProvider.callMessageReceived(cloudEvent);
          } else {
            log.i('dash getSaved AmigoCloudEvent() == ' + snapshot.data.toString());
          }

          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: dashboardProvider.currentIndex,
              onTap: (int index) => dashboardProvider.currentIndex = index,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Familie'),
                BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Amigo-Karten'),
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
        });

    void askXiamiPerm() {
      AndroidIntent permIntent = const AndroidIntent(
          action: 'miui.intent.action.APP_PERM_EDITOR',
          arguments: {'extra_pkgname': 'org.ossiaustria.amigoapp.debug'});
      permIntent.launch();
    }
  }
}
