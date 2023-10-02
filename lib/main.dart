import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const appTitle = '小冰冰, 启动!';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appTitle,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/equipment', page: () => const HomePage()),
        GetPage(name: '/hero', page: () => const HomePage())
      ],
      // home: HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('首页'),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  '小冰冰, 启动!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text('首页'),
                selected: Get.currentRoute == '/',
                onTap: () {
                  Get.toNamed('/');
                },
              ),
              ListTile(
                title: const Text('装备图鉴'),
                selected: Get.currentRoute == '/equipment',
                onTap: () {
                  Get.toNamed('/equipment');
                },
              ),
              ListTile(
                title: const Text('英雄图鉴'),
                selected: Get.currentRoute == '/hero',
                onTap: () {
                  Get.toNamed('/hero');
                },
              ),
            ],
          ),
        ));
  }
}
