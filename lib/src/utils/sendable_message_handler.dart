import 'package:amigoapp/src/provider/call_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'logger.dart';

enum AmigoCloudEventType {
  call,
  message,
}

@JsonSerializable()
class AmigoCloudEvent extends Equatable {
  final AmigoCloudEventType type;
  final String entityId;
  final String receiverId;
  final String action;

  const AmigoCloudEvent(this.type, this.entityId, this.receiverId, this.action);

  static AmigoCloudEvent fromMap(Map<String, dynamic> map) => AmigoCloudEvent(
        AmigoCloudEventType.values.byName((map['type'] as String).toLowerCase()),
        map['entity_id'] as String,
        map['receiver_id'] as String,
        map['action'] as String,
      );

  AmigoCloudEvent.fromJson(Map<String, dynamic> json)
      : type = AmigoCloudEventType.message,
        entityId = json['entityId'],
        receiverId = json['receiverId'],
        action = json['action'];

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'entityId': entityId,
      'receiverId': receiverId,
      'action': action,
    };
  }

  @override
  List<Object?> get props => [type, entityId, receiverId, action];
}

class SendableMessageHandler {
  final CallProvider _callProvider;

  final log = getLogger();

  SendableMessageHandler(this._callProvider);

  void handleMessage(Map<String, dynamic> dataMap) async {
    try {
      final amigoCloudEvent = AmigoCloudEvent.fromMap(dataMap);
      log.i('Parsed AmigoCloudEvent: ' + amigoCloudEvent.toString());

      await _callProvider.callMessageReceived(amigoCloudEvent);
    } catch (e) {
      log.e('Cannot process FCM message', e);
    }
  }
}
