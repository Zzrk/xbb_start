import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xbb_start/utils/logger.dart';
import 'package:xbb_start/utils/request.dart';

class UpdateController extends GetxController {
  // 当前控制器实例
  static UpdateController get to => Get.find();

  ReceivePort _port = ReceivePort();

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  // 初始化
  @override
  void onInit() {
    super.onInit();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      // DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      int progress = data[2];
      print('下载进度：$progress');
    });
    FlutterDownloader.registerCallback(downloadCallback);

    CommonLogger.info('UpdateController init');
  }

  // 销毁
  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.onClose();

    CommonLogger.info('UpdateController close');
  }

  checkVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final latest = await CommonRequest.checkVersion();

    if (latest != null && latest['version'] == 'v$version') {
      // 打开更新对话框
      Get.defaultDialog(
        title: '发现新版本',
        content: Text(latest['content']!),
        textConfirm: '更新',
        textCancel: '取消',
        confirmTextColor: Colors.white,
        onConfirm: () async {
          // 获取存储卡的路径
          final directory = await getExternalStorageDirectory();
          String _localPath = directory!.path;
          print('存储卡路径：$_localPath');

          // OpenFile.open('${_localPath}/xbb_start_v0.1.0.apk');
          // await FlutterDownloader.enqueue(
          //   // 远程的APK地址（注意：安卓9.0以上后要求用https）
          //   url: latest['url'],
          //   // 下载保存的路径
          //   savedDir: _localPath,
          //   // 是否在手机顶部显示下载进度（仅限安卓）
          //   showNotification: true,
          //   // 是否允许下载完成点击打开文件（仅限安卓）
          //   openFileFromNotification: true,
          // );

          // Get.back();
        },
        onCancel: () {
          Get.back();
        },
      );
    }
  }
}
