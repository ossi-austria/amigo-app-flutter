import 'package:amigo_flutter/src/dto/call_token_dto.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/provider/call_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatelessWidget {
  static const routeName = '/call';

  const CallScreen({Key? key}) : super(key: key);

  String callStateToString(CallState? callState) {
    if (callState != null) {
      switch (callState) {
        case CallState.CREATED:
          return 'wird angerufen';
          break;
        case CallState.CALLING:
          return 'wird angerufen';
          break;
        case CallState.CANCELLED:
          return 'Anruf unterbrochen.';
          break;
        case CallState.DENIED:
          return 'Anruf abgelehnt.';
          break;
        case CallState.ACCEPTED:
          return 'Anruf angenommen.';
          break;
        case CallState.FINISHED:
          return 'Anruf beendet.';
          break;
        case CallState.TIMEOUT:
          return 'Anruf abgebrochen.';
          break;
      }
    } else {
      return 'Kein Anruf';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        future: callProvider.getAnalogue(),
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
                      Text(
                        callStateToString(callProvider.currentCall?.callState),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  //DialUserPic(image: 'assets/images/calling_face.png'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DialButton(
                          iconData: Icons.call_end,
                          press: () {
                            callProvider.cancelCall();
                          }),
                    ],
                  ),
                  /*Align(
                    alignment: Alignment.bottomCenter,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        DialButton(iconData: Icons.mic, press: () {}),
                        DialButton(iconData: Icons.volume_mute, press: () {}),
                        DialButton(iconData: Icons.camera, press: () {}),
                        const SizedBox(
                          width: 40,
                        ),
                        DialButton(iconData: Icons.call_end, press: () {}),
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DialButton extends StatelessWidget {
  const DialButton({
    Key? key,
    required this.iconData,
    required this.press,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: ElevatedButton(
        onPressed: press,
        child: Icon(iconData),
      ),
    );
  }
}
