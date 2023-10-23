import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// toast widget
class ToastWidget extends StatelessWidget {
  const ToastWidget({super.key, required this.msg});

  final String msg;

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
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const Icon(Icons.check),
          // const SizedBox(width: 12.0),
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

  void showToast(String msg) {
    fToast.showToast(
      child: ToastWidget(msg: msg),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
