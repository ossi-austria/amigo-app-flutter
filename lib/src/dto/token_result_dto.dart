import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_result_dto.g.dart';

@JsonSerializable()
class TokenResultDto extends Equatable {
  final String token;
  final String subject;
  final DateTime issuedAt;
  final DateTime expiration;
  final String issuer;

  const TokenResultDto(
      this.token, this.subject, this.issuedAt, this.expiration, this.issuer);

  static const fromJson = _$TokenResultDtoFromJson;

  Map<String, dynamic> toJson() => _$TokenResultDtoToJson(this);

  @override
  List<Object?> get props => [token, subject, issuedAt, expiration, issuer];
}
