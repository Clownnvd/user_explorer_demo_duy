import 'package:logger/logger.dart';

/// Global logging instance with pretty format
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,        // số dòng method stack trace
      errorMethodCount: 5,
      lineLength: 90,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// Log info
  static void info(String message, {String? name}) {
    _logger.i(_format(message, name));
  }

  /// Log debug
  static void debug(String message, {String? name}) {
    _logger.d(_format(message, name));
  }

  /// Log warning
  static void warn(String message, {String? name}) {
    _logger.w(_format(message, name));
  }

  /// Log error
  static void error(String message, {String? name, dynamic error, StackTrace? stack}) {
    _logger.e(_format(message, name), error: error, stackTrace: stack);
  }

  /// Format: [Module] message
  static String _format(String msg, String? name) {
    if (name == null) return msg;
    return "[$name] $msg";
  }
}
