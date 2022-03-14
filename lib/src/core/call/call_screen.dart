import 'package:amigoapp/src/config/themes/default_theme.dart';
import 'package:amigoapp/src/dto/call_token_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatelessWidget {
  static const routeName = '/call';

  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);

    return Consumer<CallProvider>(
      builder: (BuildContext context, callProvider, Widget? child) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      FutureBuilder<PersonDto?>(
                        future: groupProvider.getAnalogue(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            );
                          }
                          return const Text('loading');
                        },
                      ),
                      FutureBuilder<bool>(
                          future: callProvider.isIncomingCall(),
                          builder: (context, isIncomingCall) {
                            if (isIncomingCall.hasData) {
                              if (isIncomingCall.data == true) {
                                return Text(
                                  incomingString(callProvider.currentCall?.callState),
                                  style: const TextStyle(color: Colors.white),
                                );
                              } else {
                                return Text(
                                  outgoingString(callProvider.currentCall?.callState),
                                  style: const TextStyle(color: Colors.white),
                                );
                              }
                            } else {
                              return const Text(
                                '...',
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          }),
                    ],
                  ),
                  const Spacer(),
                  //DialUserPic(image: 'assets/images/calling_face.png'),

                  FutureBuilder<bool>(
                      future: callProvider.isIncomingCall(),
                      builder: (context, isIncomingCall) {
                        if (isIncomingCall.hasData) {
                          if (isIncomingCall.data == true) {
                            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              // CALL is incoming
                              DialButton(
                                  iconData: Icons.call,
                                  color: AmigoColors.secondaryColor,
                                  press: () => callProvider.acceptIncomingCall()),
                              DialButton(
                                  iconData: Icons.call_end,
                                  color: AmigoColors.redColor,
                                  press: () => callProvider.denyCall())
                            ]);
                          } else {
                            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              // CALL is outgoing
                              DialButton(
                                  iconData: Icons.call_end,
                                  color: AmigoColors.redColor,
                                  press: () => callProvider.cancelCall()),
                            ]);
                          }
                        } else {
                          return const Text('Undefined state');
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static String outgoingString(CallState? callState) {
    if (callState != null) {
      switch (callState) {
        case CallState.CREATED:
          return 'wird angerufen';
        case CallState.CALLING:
          return 'wird angerufen';
        case CallState.CANCELLED:
          return 'abgebrochen.';
        case CallState.DENIED:
          return 'Anruf abgelehnt.';
        case CallState.ACCEPTED:
          return 'Anruf angenommen.';
        case CallState.FINISHED:
          return 'Anruf beendet.';
        case CallState.TIMEOUT:
          return 'Anruf abgebrochen.';
      }
    } else {
      return 'Kein Anruf';
    }
  }

  static String incomingString(CallState? callState) {
    if (callState != null) {
      switch (callState) {
        case CallState.CREATED:
          return 'ruft an';
        case CallState.CALLING:
          return 'ruft an';
        case CallState.CANCELLED:
          return 'Anruf unterbrochen.';
        case CallState.DENIED:
          return 'Anruf abgelehnt.';
        case CallState.ACCEPTED:
          return 'Anruf angenommen.';
        case CallState.FINISHED:
          return 'Anruf beendet.';
        case CallState.TIMEOUT:
          return 'Anruf abgebrochen.';
      }
    } else {
      return 'Kein Anruf';
    }
  }
}

class DialButton extends StatelessWidget {
  const DialButton({
    Key? key,
    required this.iconData,
    required this.press,
    required this.color,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ElevatedButton(
            onPressed: press,
            style: ElevatedButton.styleFrom(primary: color),
            child: Column(
              children: [Icon(iconData)],
            ),
          ),
        ));
  }
}
