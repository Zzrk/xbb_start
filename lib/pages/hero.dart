import 'package:flutter/material.dart';
import 'package:xbb_start/components/drawer.dart';

class HeroPage extends StatelessWidget {
  const HeroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('英雄图鉴'),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
        drawer: const GlobalDrawer());
  }
}
