
import 'package:logger/logger.dart';

Logger getLogger() {
  return Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      methodCount: 0,
      errorMethodCount: 5,
    ),
  );
}