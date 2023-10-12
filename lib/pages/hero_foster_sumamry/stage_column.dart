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
    final hero = fosterInfo.hero;

    return Expanded(
      child: Column(
        children: [
          Text(type),
          DropdownButton(
            items: dropdownItems,
            value: type == 'from' ? fosterInfo.from : fosterInfo.to,
            onChanged: (value) => c.modifyFromOrTo(hero, type, value!),
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
    final hero = fosterInfo.hero;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final stage = hero.stages.firstWhere((element) =>
            element.stage ==
            (type == 'from' ? fosterInfo.from : fosterInfo.to));
        openDialog(
          title: '编辑装备',
          stage: stage,
          fosterInfo: fosterInfo,
          type: type,
          context: context,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            6,
            (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    top: 8,
                  ),
                  decoration: BoxDecoration(
                    color: ((type == 'from'
                                        ? fosterInfo.fromState
                                        : fosterInfo.toState) >>
                                    (5 - index) &
                                1 ==
                            0)
                        ? Colors.grey[300]
                        : Colors.grey[600],
                  ),
                )).toList(),
      ),
    );
  }
}

void openDialog({
  required String title,
  required HeroStage stage,
  required HeroFosterInfo fosterInfo,
  required String type,
  required BuildContext context,
}) {
  final HeroInfoController c = Get.find();
  final EquipmentController c1 = Get.find();
  final hero = fosterInfo.hero;

  Get.defaultDialog(
    content: Padding(
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
                  final equipment = c1.equipmentData['item']!
                      .firstWhere((element) => element.name == equipmentName);

                  return DialogImage(
                    equipment: equipment,
                    onTap: () => c.modifyFromOrToState(hero, type, e),
                    isGrey: (type == 'from'
                                        ? fosterInfo.fromState
                                        : fosterInfo.toState) >>
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
                  final equipment = c1.equipmentData['item']!
                      .firstWhere((element) => element.name == equipmentName);
                  return DialogImage(
                    equipment: equipment,
                    onTap: () => c.modifyFromOrToState(hero, type, e),
                    isGrey: (type == 'from'
                                        ? fosterInfo.fromState
                                        : fosterInfo.toState) >>
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
    ),
  );
}

class DialogImage extends StatelessWidget {
  const DialogImage(
      {super.key,
      required this.equipment,
      required this.isGrey,
      required this.onTap});

  final Equipment equipment;
  final bool isGrey;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            EquipmentImage(equipment: equipment, imageSize: 64, isGrey: isGrey),
      ),
    );
  }
}
