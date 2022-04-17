import 'package:amigoapp/src/component/history_item.dart';
import 'package:amigoapp/src/dto/call_token_dto.dart';
import 'package:amigoapp/src/dto/group_dto.dart';
import 'package:amigoapp/src/dto/message_token_dto.dart';
import 'package:amigoapp/src/provider/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageHistoryItemWidget extends StatelessWidget {
  final MessageTokenDto _messageTokenDto;

  const MessageHistoryItemWidget(this._messageTokenDto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groupProvider, child) {
        bool incoming =
            _messageTokenDto.senderId == groupProvider.selectedGroup!.analogue!.id;
        return groupProvider.selectedGroup != null &&
                groupProvider.selectedGroup!.analogue != null
            ? HistoryItemWidget(
                incoming,
                _messageTokenDto.createdAt,
                widget: ListTile(
                  title: Text(
                    _messageTokenDto.text,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
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
