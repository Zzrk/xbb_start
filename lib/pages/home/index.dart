import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/controllers/home.dart';
import 'package:xbb_start/pages/home/calendar.dart';
import 'package:xbb_start/pages/home/code.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/utils/toast.dart';

// 首页
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.find();
    final toaster = CommonToast(context);

    Future<void> reRequest() async {
      final result = await c.reRequest();
      if (!result) toaster.errorRefresh();
    }

    if (!c.isInit.value) {
      // 重新请求一次
      reRequest();
      c.isInit.value = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: RefreshIndicator(
        onRefresh: () => reRequest(),
        child: ListView(children: const [
          Calendar(),
          CodeList(),
        ]),
      ),
      drawer: const GlobalDrawer(),
    );
  }
}
