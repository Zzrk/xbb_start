import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/main_app.dart';
import 'package:xbb_start/utils/env.dart';

void main() {
  Get.put(BuildEnvironment.dev('http://122.51.216.75:8000/'));
  runApp(const MainApp());
}
