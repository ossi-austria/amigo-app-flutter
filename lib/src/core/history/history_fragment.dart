import 'package:amigo_flutter/src/core/history/component/call_history_item.dart';
import 'package:amigo_flutter/src/dto/sendable_dto.dart';
import 'package:amigo_flutter/src/provider/history_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryFragment extends StatelessWidget {
  const HistoryFragment({Key? key}) : super(key: key);

  List<Widget> createDateGroupedSendableList(HistoryProvider historyProvider) {
    final Map<SendableDto, Widget> sendableMap = {};
    for (var e in historyProvider.receivedCalls) {
      sendableMap[e] = CallHistoryItemWidget(e);
    }
    for (var e in historyProvider.sentCalls) {
      sendableMap[e] = CallHistoryItemWidget(e);
    }

    final sortedEntries = sendableMap.entries.toList()
      ..sort((e1, e2) => e1.key.createdAt.compareTo(e2.key.createdAt));
    final grouped = sortedEntries.groupListsBy(
        (element) => DateFormat('d. MMMM yyyy').format(element.key.createdAt));
    List<Widget> test = grouped.entries.fold(
      [],
      (prev, value) => prev
        ..add(
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 12,
            ),
            child: Text(value.key),
          ),
        )
        ..addAll(value.value.map((e) => e.value)),
    );
    return test;
  }

  @override
  Widget build(BuildContext context) {
    final nonListeningHistoryProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    nonListeningHistoryProvider.refresh();

    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, child) {
        final _controller = ScrollController();

        WidgetsBinding.instance?.addPostFrameCallback((_) {
          _controller.animateTo(_controller.position.maxScrollExtent,
              duration: const Duration(microseconds: 1), curve: Curves.easeOut);
        });

        return SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: createDateGroupedSendableList(historyProvider),
          ),
        );
      },
    );
  }
}
