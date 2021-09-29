import 'package:amigo_flutter/src/dto/rest_exception_dto.dart';
import 'package:chopper/chopper.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class JsonSerializableConverter extends JsonConverter {
  final Map<Type, JsonFactory> factories;

  const JsonSerializableConverter(this.factories);

  T? _decodeMap<T>(Map<String, dynamic> values) {
    /// Get jsonFactory using Type parameters
    /// if not found or invalid, throw error or return null
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      /// throw serializer not found error;
      return null;
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(List values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v)).toList();

  dynamic _decode<T>(entity) {
    if (entity is Iterable) return _decodeList<T>(entity.toList());

    if (entity is Map<String, dynamic>) return _decodeMap<T>(entity);

    return entity;
  }

  @override
  Response<ResultType> convertResponse<ResultType, Item>(Response response) {
    final jsonRes = super.convertResponse(response);

    return jsonRes.copyWith<ResultType>(body: _decode<Item>(jsonRes.body));
  }

  @override
  Response convertError<ResultType, Item>(Response response) {
    final jsonRes = super.convertError(response);

    try {
      return jsonRes.copyWith<RestExceptionDto>(
        body: RestExceptionDto.fromJson(jsonRes.body),
      );
    } catch (e) {
      return jsonRes;
    }
  }
}
