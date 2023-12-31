import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/components/filter_button.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/declaration/index.dart';
import 'package:xbb_start/utils/toast.dart';

// 装备图鉴
class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EquipmentController c = Get.find();
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

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('装备图鉴'),
            bottom: const TabBar(
              tabs: [
                Tab(text: '装备'),
                Tab(text: '碎片'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              EquipmentContent(type: 'item'),
              EquipmentContent(type: 'fragment'),
            ],
          ),
          floatingActionButton: Obx(() => FilterButton(
                filterMenus: [
                  SelectFilterMenu(
                    title: '装备品质',
                    value: c.filter['quality']!,
                    options: equipmentQualityList,
                    onChange: (value) {
                      c.toggleFilter('quality', value);
                      c.triggerFilter();
                    },
                  ),
                ],
              )),
          drawer: const GlobalDrawer(),
        ));
  }
}

// 图鉴列表内容
class EquipmentContent extends StatelessWidget {
  const EquipmentContent({super.key, this.type = 'item'});

  final String type;

  @override
  Widget build(BuildContext context) {
    final EquipmentController c = Get.find();
    final toaster = CommonToast(context);

    Future<void> reRequest() async {
      final result = await c.reRequest();
      if (!result) toaster.errorRefresh();
    }

    return RefreshIndicator(
      onRefresh: () => reRequest(),
      child: Obx(() => GridView.builder(
            itemCount: c.showEquipmentData[type]!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (context, index) => EquipmentItem(equipment: c.showEquipmentData[type]![index]),
          )),
    );
  }
}
