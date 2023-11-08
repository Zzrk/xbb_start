import 'package:xbb_start/utils/request.dart';

enum BuildFlavor { dev, release }

class BuildEnvironment {
  // 环境区分
  late BuildFlavor flavor;

  BuildEnvironment.dev() {
    flavor = BuildFlavor.dev;
    CommonRequest.setup('http://10.0.2.2:8000/');
  }

  BuildEnvironment.release() {
    flavor = BuildFlavor.release;
    CommonRequest.setup('http://122.51.216.75:8000/');
  }
}
