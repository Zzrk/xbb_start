import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:xbb_start/utils/logger.dart';
import 'package:xbb_start/utils/request.dart';

class UpdateController extends GetxController {
  // 当前控制器实例
  static UpdateController get to => Get.find();

  var id = 0.obs;
  var speed = 0.obs;
  var percent = 0.obs;
  var status = DownloadStatus.STATUS_PENDING.obs;

  // 初始化
  @override
  void onInit() {
    super.onInit();
    RUpgrade.stream.listen((DownloadInfo info) {
      // 保留整数部分
      speed.value = info.speed?.toInt() ?? speed.value;
      percent.value = info.percent?.toInt() ?? percent.value;
      status.value = info.status ?? DownloadStatus.STATUS_PENDING;
      CommonLogger.info(info.status);
      if (info.status == DownloadStatus.STATUS_SUCCESSFUL) {
        Get.back();
      }
    });
    CommonLogger.info('UpdateController init');
  }

  // 销毁
  @override
  void onClose() {
    super.onClose();
    CommonLogger.info('UpdateController close');
  }

  checkVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final version = 'v${packageInfo.version}';
    final latest = await CommonRequest.checkVersion();

    if (latest != null && latest['version'] != version) {
      // 打开更新内容对话框
      Get.dialog(
        Obx(
          () => Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text('发现新版本',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      )),
                  const SizedBox(height: 20),
                  Text(latest['content'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      )),
                  const SizedBox(height: 20),
                  if (status.value == DownloadStatus.STATUS_PENDING)
                    Row(
                      children: [
                        // 取消按钮
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              RUpgrade.cancel(id.value);
                              Get.back();
                            },
                            child: const Text('取消'),
                          ),
                        ),
                        // 更新按钮
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              final version = latest['version'];
                              id.value = await RUpgrade.upgrade(
                                    latest['url'],
                                    fileName: 'xbb_start_$version.apk',
                                    installType: RUpgradeInstallType.normal,
                                  ) ??
                                  0;
                              CommonLogger.info('开始更新: $id');
                            },
                            child: const Text('更新'),
                          ),
                        ),
                      ],
                    )
                  else
                    // 与 TextButton 占据相同控件的进度条
                    Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 10,
                        child: LinearProgressIndicator(
                          value: percent.value / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }
}
