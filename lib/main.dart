import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/main_app.dart';
import 'package:xbb_start/utils/env.dart';

void main() async {
  // 初始化环境变量
  Get.put(BuildEnvironment.release());

  runApp(const MainApp());
}
