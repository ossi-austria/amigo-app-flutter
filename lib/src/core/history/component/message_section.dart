import 'package:amigoapp/src/provider/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageSection extends StatelessWidget {
  const MessageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Consumer<HistoryProvider>(
            builder: (context, historyProvider, child) {
              return Scrollbar(
                child: TextField(
                  controller: TextEditingController()..text = historyProvider.enteredText ?? '',
                  minLines: 1,
                  maxLines: 6,
                  onChanged: historyProvider.setEnteredText,
                  decoration: InputDecoration(
                      hintText: 'Nachricht ...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        FloatingActionButton(
          onPressed: () {
            final _historyProvider = Provider.of<HistoryProvider>(context, listen: false);
            _historyProvider.sendMessage();
          },
          child: const Icon(
            Icons.send,
            color: Colors.black,
            size: 18,
          ),
          elevation: 0,
        ),
      ],
    );
  }
}
