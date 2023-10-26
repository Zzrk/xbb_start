import 'package:logger/logger.dart';

class CommonLogger {
  static final logger = Logger();

  static final info = logger.i;

  static final warning = logger.w;

  static final error = logger.e;

  static final debug = logger.d;
}
