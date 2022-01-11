import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_fcm_token_request.g.dart';

@JsonSerializable()
class SetFcmTokenRequest extends Equatable {
  final String fcmToken;

  const SetFcmTokenRequest(this.fcmToken);

  static const fromJson = _$SetFcmTokenRequestFromJson;

  Map<String, dynamic> toJson() => _$SetFcmTokenRequestToJson(this);

  @override
  List<Object> get props => [fcmToken];
}
