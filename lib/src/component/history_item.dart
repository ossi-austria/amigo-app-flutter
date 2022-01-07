import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItemWidget extends StatelessWidget {
  final bool incoming;
  final DateTime dateTime;
  final Widget? widget;

  const HistoryItemWidget(this.incoming, this.dateTime, {this.widget, Key? key})
      : super(key: key);

  Widget timeText() {
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        right: incoming ? 0 : 15,
        left: incoming ? 15 : 0,
      ),
      child: Text(
        DateFormat('HH:mm').format(dateTime),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!incoming) timeText(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: incoming
                    ? const Color(0xFFB5CDD0)
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: incoming ? Radius.zero : const Radius.circular(32),
                  topRight: incoming ? const Radius.circular(32) : Radius.zero,
                  bottomLeft: const Radius.circular(32),
                  bottomRight: const Radius.circular(32),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: widget,
              ),
            ),
          ),
          if (incoming) timeText(),
        ],
      ),
    );
  }
}
