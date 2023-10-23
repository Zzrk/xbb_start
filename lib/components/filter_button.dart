import 'package:flutter/material.dart';

class FilterMenu {
  final String type;
  final String title;
  final String value;
  final List<String> options;
  final void Function(String value) onChange;

  const FilterMenu({
    required this.type,
    required this.title,
    required this.value,
    required this.options,
    required this.onChange,
  });
}

class SelectFilterMenu extends FilterMenu {
  const SelectFilterMenu({
    required String title,
    required String value,
    required List<String> options,
    required void Function(String value) onChange,
  }) : super(
          type: 'select',
          title: title,
          value: value,
          options: options,
          onChange: onChange,
        );
}

// class InputFilterMenu extends FilterMenu {
//   const InputFilterMenu({
//     required String title,
//     required String value,
//     required void Function(String value) onChange,
//   }) : super(
//           type: 'input',
//           title: title,
//           value: value,
//           options: const [],
//           onChange: onChange,
//         );
// }

class FilterButton extends StatelessWidget {
  const FilterButton({required this.filterMenus, super.key});
  final List<FilterMenu> filterMenus;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          // 弹出过滤器
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...filterMenus.map((e) {
                      if (e.type == 'select') {
                        return Column(
                          children: [
                            Text(e.title),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                ...e.options.map((option) {
                                  return ChoiceChip(
                                    label: Text(option.isEmpty ? '全部' : option),
                                    selected: e.value == option,
                                    onSelected: (value) {
                                      e.onChange(option);
                                      Navigator.pop(context);
                                    },
                                  );
                                }).toList(),
                              ],
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    }).toList(),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.filter_list,
        ));
  }
}
