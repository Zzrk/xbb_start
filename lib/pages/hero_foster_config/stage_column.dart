import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbb_start/components/equipment.dart';
import 'package:xbb_start/controllers/equipment.dart';
import 'package:xbb_start/controllers/hero.dart';
import 'package:xbb_start/declaration/equipment.dart';
import 'package:xbb_start/declaration/hero.dart';
import 'package:xbb_start/declaration/index.dart';

class StageColumn extends StatelessWidget {
  const StageColumn({super.key, required this.fosterInfo, required this.type});

  final HeroFosterInfo fosterInfo;
  final String type;

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();

    return Expanded(
      child: Column(
        children: [
          Text(type),
          DropdownButton(
            items: dropdownItems,
            value: type == 'from' ? fosterInfo.from : fosterInfo.to,
            onChanged: (value) => c.modifyFromOrTo(fosterInfo.hero, type, value!),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          StageRow(
            fosterInfo: fosterInfo,
            type: type,
          )
        ],
      ),
    );
  }
}

class StageRow extends StatelessWidget {
  const StageRow({super.key, required this.fosterInfo, required this.type});

  final HeroFosterInfo fosterInfo;
  final String type;

  @override
  Widget build(BuildContext context) {
    final state = type == 'from' ? fosterInfo.fromState : fosterInfo.toState;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: DialogWidget(
              title: '编辑装备',
              fosterInfo: fosterInfo,
              type: type,
              fatherContext: context,
            ),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(6, (index) {
          return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(left: 2, right: 2, top: 8),
              decoration: BoxDecoration(
                color: (state >> (5 - index) & 1 == 0) ? Colors.grey[300] : Colors.grey[600],
              ));
        }).toList(),
      ),
    );
  }
}

class DialogWidget extends StatelessWidget {
  const DialogWidget(
      {super.key, required this.title, required this.fosterInfo, required this.type, required this.fatherContext});

  final String title;
  final HeroFosterInfo fosterInfo;
  final String type;
  final BuildContext fatherContext;

  @override
  Widget build(BuildContext context) {
    final HeroInfoController c = Get.find();
    final EquipmentController c1 = Get.find();
    final hero = fosterInfo.hero;
    final stageName = type == 'from' ? fosterInfo.from : fosterInfo.to;
    final stage = fosterInfo.hero.stages.firstWhere((element) => element.stage == stageName);

    return Obx(() => Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [0, 1, 2].map((e) {
                      final equipmentName = stage.equipments[e];

                      if (equipmentName.isEmpty) {
                        return Container(
                          width: 76.8,
                          height: 76.8,
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(child: Text('暂无数据')),
                        );
                      }

                      final equipment =
                          c1.equipmentData['item']!.firstWhere((element) => element.name == equipmentName);

                      return DialogImage(
                        equipment: equipment,
                        onTap: () => c.modifyFromOrToState(hero, type, e),
                        isGrey: (type == 'from'
                                            ? c.fosterList.firstWhere((element) => element.hero == hero).fromState
                                            : c.fosterList.firstWhere((element) => element.hero == hero).toState) >>
                                        (5 - e) &
                                    1 ==
                                0
                            ? true
                            : false,
                      );
                    }).toList(),
                  ),
                  Column(
                    children: [3, 4, 5].map((e) {
                      final equipmentName = stage.equipments[e];

                      if (equipmentName.isEmpty) {
                        return Container(
                          width: 76.8,
                          height: 76.8,
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(child: Text('暂无数据')),
                        );
                      }

                      final equipment =
                          c1.equipmentData['item']!.firstWhere((element) => element.name == equipmentName);

                      return DialogImage(
                        equipment: equipment,
                        onTap: () => c.modifyFromOrToState(hero, type, e),
                        isGrey: (type == 'from'
                                            ? c.fosterList.firstWhere((element) => element.hero == hero).fromState
                                            : c.fosterList.firstWhere((element) => element.hero == hero).toState) >>
                                        (5 - e) &
                                    1 ==
                                0
                            ? true
                            : false,
                      );
                    }).toList(),
                  )
                ],
              ),
              TextButton(
                child: const Text('确认'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}

class DialogImage extends StatelessWidget {
  const DialogImage({super.key, required this.equipment, required this.isGrey, required this.onTap});

  final Equipment equipment;
  final bool isGrey;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EquipmentImage(equipment: equipment, imageSize: 64, isGrey: isGrey),
      ),
    );
  }
}
