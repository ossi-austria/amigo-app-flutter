import 'package:amigo_flutter/src/dto/secret_account_dto.dart';
import 'package:amigo_flutter/src/dto/token_result_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_result_dto.g.dart';

@JsonSerializable()
class LoginResultDto extends Equatable {
  final SecretAccountDto account;
  final TokenResultDto refreshToken;
  final TokenResultDto accessToken;

  const LoginResultDto(this.account, this.refreshToken, this.accessToken);

  static const fromJson = _$LoginResultDtoFromJson;

  Map<String, dynamic> toJson() => _$LoginResultDtoToJson(this);

  @override
  List<Object?> get props => [account, refreshToken, accessToken];
}
