import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// toast widget
class ToastWidget extends StatelessWidget {
  const ToastWidget({super.key, required this.msg, required this.icon});

  final String msg;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 12.0),
          Text(msg),
        ],
      ),
    );
  }
}

// use toast
class CommonToast {
  late FToast fToast;

  CommonToast(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
  }

  void info(String msg) {
    fToast.showToast(
      child: ToastWidget(msg: msg, icon: Icons.info),
      gravity: ToastGravity.TOP,
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: Get.statusBarHeight,
          left: 24.0,
          right: 24.0,
          child: child,
        );
      },
      toastDuration: const Duration(seconds: 2),
    );
  }

  void error(String msg) {
    fToast.showToast(
      child: ToastWidget(msg: msg, icon: Icons.cancel),
      gravity: ToastGravity.TOP,
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: Get.statusBarHeight,
          left: 24.0,
          right: 24.0,
          child: child,
        );
      },
      toastDuration: const Duration(seconds: 2),
    );
  }

  void errorRefresh() {
    error('数据更新失败');
  }
}
