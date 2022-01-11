import 'package:amigo_flutter/src/provider/call_provider.dart';

enum AmigoCloudEventType {
  call,
  message,
}

class AmigoCloudEvent {
  final AmigoCloudEventType type;
  final String entityId;
  final String receiverId;
  final String action;

  AmigoCloudEvent(this.type, this.entityId, this.receiverId, this.action);

  static AmigoCloudEvent fromMap(Map<String, dynamic> map) => AmigoCloudEvent(
        AmigoCloudEventType.values
            .byName((map['type'] as String).toLowerCase()),
        map['entity_id'] as String,
        map['receiver_id'] as String,
        map['action'] as String,
      );
}

class SendableMessageHandler {
  final CallProvider _callProvider;

  SendableMessageHandler(this._callProvider);

  void handleMessage(Map<String, dynamic> dataMap) async {
    try {
      final amigoCloudEvent = AmigoCloudEvent.fromMap(dataMap);
      await _callProvider.callMessageReceived(amigoCloudEvent);
    } catch (e) {
      // TODO: handle error
    }
  }
}
