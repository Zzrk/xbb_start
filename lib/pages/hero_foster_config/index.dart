import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/foster_summary.dart';
import 'package:xbb_start/pages/hero_foster_config/foster_grid_view.dart';

// 养成设置
class HeroFosterConfigPage extends StatelessWidget {
  const HeroFosterConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FosterSummaryController c = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('英雄养成设置'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: '确认',
            onPressed: () {
              c.compute();
              Get.toNamed('/hero_foster_summary');
            },
          ),
        ],
      ),
      body: const FosterGridView(),
      drawer: const GlobalDrawer(),
    );
  }
}
