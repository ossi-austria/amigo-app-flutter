import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  static const fromJson = _$LoginRequestFromJson;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
