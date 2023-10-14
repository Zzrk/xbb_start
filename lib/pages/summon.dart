import 'package:flutter/material.dart';
import 'package:xbb_start/components/drawer.dart';

// 召唤
class SummonPage extends StatelessWidget {
  const SummonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: const Text('我的回合, 抽卡'),
      drawer: const GlobalDrawer(),
    );
  }
}
