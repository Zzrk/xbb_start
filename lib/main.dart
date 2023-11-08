import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:xbb_start/main_app.dart';
import 'package:xbb_start/utils/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
    debug: true, // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl: true, // option: set to false to disable working with http links (default: false)
  );

  // 初始化环境变量
  Get.put(BuildEnvironment.release());

  runApp(const MainApp());
}
