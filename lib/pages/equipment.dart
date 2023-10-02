import 'package:flutter/material.dart';
import 'package:xbb_start/components/drawer.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('装备图鉴'),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
        drawer: const GlobalDrawer());
  }
}
