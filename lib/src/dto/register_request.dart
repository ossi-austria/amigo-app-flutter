import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String email;
  final String password;
  final String name;

  RegisterRequest(this.email, this.password, this.name);

  static const fromJson = _$RegisterRequestFromJson;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
