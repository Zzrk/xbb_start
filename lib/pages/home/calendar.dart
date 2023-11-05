import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xbb_start/controllers/home.dart';
import 'package:xbb_start/utils/index.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.find();

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    return Obx(() => Card(
          child: Column(children: [
            const ListTile(
              title: Text(
                '当前活动',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // trailing: TextButton(
              //   onPressed: () {
              //     // 强制横屏
              //     SystemChrome.setPreferredOrientations([
              //       DeviceOrientation.landscapeLeft,
              //       DeviceOrientation.landscapeRight,
              //     ]);
              //     showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return const Dialog.fullscreen(
              //             backgroundColor: Colors.transparent,
              //             child: CalendarDialog(),
              //           );
              //         });
              //   },
              //   child: const Text('活动日历'),
              // ),
            ),
            const Divider(),
            ...List.generate(c.currentActivity.length, (index) {
              final activity = c.currentActivity[index];
              return Column(children: [
                Text(activity.title),
                Text(formatDuration(activity.beginTime, activity.endTime)),
                const Divider(),
              ]);
            }),
            if (c.currentActivity.isEmpty) const Text('暂无活动'),
            const SizedBox(height: 8)
          ]),
        ));
  }
}

// TODO: CalendarDialog Size
class CalendarDialog extends StatelessWidget {
  const CalendarDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/calendar/bg.png'),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(children: [
        Container(
          height: context.mediaQueryShortestSide - Get.statusBarHeight,
          decoration: const BoxDecoration(color: Colors.amber),
        )
        // const Expanded(
        //   flex: 1,
        //   child: SizedBox(),
        // ),
        // Expanded(
        //   flex: 3,
        //   child: Center(
        //     child: Image.asset(
        //       'assets/calendar/title.png',
        //     ),
        //   ),
        // ),
        // Expanded(
        //   flex: 30,
        //   child: ListView(
        //       scrollDirection: Axis.horizontal,
        //       // 显示今天和之前之后一周的日期
        //       children: List.generate(15, (index) {
        //         final now = DateTime.now();
        //         final date = now.add(Duration(days: index - 7));
        //         return Container(
        //           width: 100,
        //           child: Column(
        //             children: [
        //               Text('${date.month}月${date.day}日'),
        //               Text('星期${weekList[date.weekday - 1]}'),
        //             ],
        //           ),
        //         );
        //       })),
        // ),
      ]),
    );
  }
}
