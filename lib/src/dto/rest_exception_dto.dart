import 'package:json_annotation/json_annotation.dart';

part 'rest_exception_dto.g.dart';

@JsonSerializable()
class RestExceptionDto {
  final int errorCode;
  final String errorName;
  final String errorMessage;
  final DateTime time;

  RestExceptionDto(
      this.errorCode, this.errorName, this.errorMessage, this.time);

  static const fromJson = _$RestExceptionDtoFromJson;

  Map<String, dynamic> toJson() => _$RestExceptionDtoToJson(this);
}
