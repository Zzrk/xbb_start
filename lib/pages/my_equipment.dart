import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xbb_start/components/drawer.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/controllers/my_equipment.dart';
import 'package:xbb_start/declaration/equipment.dart';
import 'package:xbb_start/utils/toast.dart';

// 我的装备
class MyEquipmentPage extends StatelessWidget {
  const MyEquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('我的装备'),
            bottom: const TabBar(
              tabs: [
                Tab(text: '装备'),
                Tab(text: '碎片'),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: '添加',
                onPressed: () {
                  // 获取当前选中的tab
                  final type = DefaultTabController.of(context).index == 0 ? 'item' : 'fragment';
                  openDialog(context, type, '');
                },
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              EquipmentContent(type: 'item'),
              EquipmentContent(type: 'fragment'),
            ],
          ),
          drawer: const GlobalDrawer(),
        );
      }),
    );
  }
}

// 列表内容
class EquipmentContent extends StatelessWidget {
  const EquipmentContent({super.key, this.type = 'item'});

  final String type;

  @override
  Widget build(BuildContext context) {
    final MyEquipmentController c = Get.find();
    final EquipmentController c0 = Get.find();

    return Obx(() => GridView.count(
          crossAxisCount: 4,
          children: c.myEquipmentData[type]!.map((element) {
            final equipment = c0.equipmentData[type]!.firstWhere((e) => e.name == element.name);

            return EquipmentItem(
              equipment: equipment,
              count: element.count,
              onLongPress: () {
                openDialog(context, type, equipment.name);
              },
            );
          }).toList(),
        ));
  }
}

typedef Confirm = void Function(String name, int count);
void openDialog(
  BuildContext context,
  String type,
  String name,
) {
  final myController = TextEditingController();
  final toaster = CommonToast(context);
  final MyEquipmentController c = Get.find();
  final EquipmentController c0 = Get.find();

  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name.isNotEmpty ? '修改装备数量' : '添加装备',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            name.isNotEmpty
                ? Text(name)
                : DropdownSearch<Equipment>(
                    filterFn: (item, filter) => item.name.contains(filter),
                    items: c0.equipmentData['total']!,
                    itemAsString: (Equipment item) => item.name,
                    onChanged: (Equipment? data) => c.updateSelectedEquipment(data!.name),
                    popupProps: const PopupProps.menu(showSearchBox: true),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(labelText: "选择装备"),
                    ),
                  ),
            const SizedBox(height: 8),
            TextField(
              controller: myController,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: '输入装备数量'),
            ),
            const SizedBox(height: 8),
            TextButton(
              child: const Text('确认'),
              onPressed: () {
                final newCount = int.tryParse(myController.text);
                if (newCount == null) {
                  toaster.error('请输入正确的数量');
                  return;
                }
                final equipment = name.isEmpty ? c.selectedEquipment : name;
                c.updateMyEquipment(type, equipment, newCount);
                toaster.info('修改成功');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
