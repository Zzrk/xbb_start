import 'package:xbb_start/utils/request.dart';

enum BuildFlavor { dev, release }

class BuildEnvironment {
  late BuildFlavor flavor;
  late String apiBaseUrl;

  BuildEnvironment.dev(String apiBaseUrl) {
    flavor = BuildFlavor.dev;
    apiBaseUrl = apiBaseUrl;
    CommonRequest.setup(apiBaseUrl);
  }

  BuildEnvironment.release(String apiBaseUrl) {
    flavor = BuildFlavor.release;
    apiBaseUrl = apiBaseUrl;
    CommonRequest.setup(apiBaseUrl);
  }
}
