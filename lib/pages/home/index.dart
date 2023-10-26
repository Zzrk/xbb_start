import 'package:flutter/material.dart';
import 'package:xbb_start/pages/home/calendar.dart';
import 'package:xbb_start/pages/home/code.dart';
import 'package:xbb_start/components/drawer.dart';

// 首页
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: ListView(children: const [
        Calendar(),
        CodeList(),
      ]),
      drawer: const GlobalDrawer(),
    );
  }
}
