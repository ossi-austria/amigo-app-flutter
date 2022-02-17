import 'dart:async';

import 'package:chopper/chopper.dart';

class ErrorResponseInterceptor implements ResponseInterceptor {
  ErrorResponseInterceptor();

  @override
  FutureOr<Response> onResponse(Response<dynamic> response) {
    if (response.statusCode > 300) {
      print('Error for request: ' + response.headers.toString());
      print(response.error);
      print(response.body);
    }
    return response;
  }
}
