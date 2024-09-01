import 'package:logger/logger.dart';

class LoggerService {
  LoggerService._();

  static void error(String msg) {
    Logger logger = Logger();
    logger.e(msg);
  }

  static void info(String msg) {
    Logger logger = Logger();
    logger.i(msg);
  }

  static void warning(String msg) {
    Logger logger = Logger();
    logger.w(msg);
  }

  static void message(String msg) {
    Logger logger = Logger();
    logger.d(msg);
  }
}
