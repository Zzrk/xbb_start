import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xbb_start/controllers/home.dart';
import 'package:xbb_start/utils/toast.dart';

class CodeList extends StatelessWidget {
  const CodeList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.find();
    final toaster = CommonToast(context);

    return Obx(() => Card(
          child: Column(children: [
            const ListTile(
              title: Text('兑换码'),
            ),
            const Divider(),
            ...List.generate(c.redeemCode.length, (index) {
              final element = c.redeemCode[index];
              return GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: element.code));
                  toaster.info('已复制兑换码');
                },
                child: Column(children: [
                  Text(element.code),
                  Text(element.desc),
                  const Divider(),
                ]),
              );
            }),
            if (c.redeemCode.isEmpty) const Text('暂无兑换码'),
            const SizedBox(height: 8)
          ]),
        ));
  }
}
