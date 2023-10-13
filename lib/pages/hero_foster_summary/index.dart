import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/controllers/hero.dart';

// 养成总结
class HeroFosterSummaryPage extends StatelessWidget {
  const HeroFosterSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('英雄养成总结')),
      body: Placeholder(),
      drawer: const GlobalDrawer(),
    );
  }
}
