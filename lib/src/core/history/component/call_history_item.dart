import 'package:amigo_flutter/src/component/history_item.dart';
import 'package:amigo_flutter/src/dto/call_token_dto.dart';
import 'package:amigo_flutter/src/dto/group_dto.dart';
import 'package:amigo_flutter/src/provider/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallHistoryItemWidget extends StatelessWidget {
  final CallTokenDto _callTokenDto;

  const CallHistoryItemWidget(this._callTokenDto, {Key? key}) : super(key: key);

  String getStatusText() {
    String text = '';

    switch (_callTokenDto.callState) {
      case CallState.CREATED:
      case CallState.CALLING:
        text = 'Läutet';
        break;
      case CallState.CANCELLED:
        text = 'Abgebrochen';
        break;
      case CallState.DENIED:
        text = 'Abgelehnt';
        break;
      case CallState.ACCEPTED:
        text = 'Angenommen';
        break;
      case CallState.FINISHED:
        Duration duration =
            _callTokenDto.finishedAt!.difference(_callTokenDto.createdAt);
        text =
            '${duration.inMinutes}:${duration.inSeconds.remainder(60)} Minuten';
        break;
      case CallState.TIMEOUT:
        text = 'Verpasst';
        break;
    }
    return text;
  }

  String getTitleText(GroupDto groupDto) {
    var calleeName = groupDto.members
        .firstWhere((element) => element.id == _callTokenDto.receiverId)
        .name;
    return 'Anruf mit $calleeName';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groupProvider, child) {
        bool incoming =
            _callTokenDto.senderId == groupProvider.selectedGroup!.analogue!.id;
        return groupProvider.selectedGroup != null &&
                groupProvider.selectedGroup!.analogue != null
            ? HistoryItemWidget(
                incoming,
                _callTokenDto.createdAt,
                widget: ListTile(
                  leading: Icon(
                    Icons.call,
                    color: incoming
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
                  title: Text(
                    getTitleText(groupProvider.selectedGroup!),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: incoming
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                  ),
                  subtitle: Text(
                    getStatusText(),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: incoming
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                  ),
                ),
              )
            : const Text('Loading');
      },
    );
  }
}
