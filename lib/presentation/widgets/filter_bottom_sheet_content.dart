import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/network_inspector_value.dart';
import '../controllers/activity_filter_provider.dart';
import 'container_label.dart';

class FilterBottomSheetContent extends StatelessWidget {
  final Map<int?, int> responseStatusCodes;
  final Function(List<int?>) onTapApplyFilter;
  final ActivityFilterProvider provider;

  const FilterBottomSheetContent({
    Key? key,
    required this.responseStatusCodes,
    required this.onTapApplyFilter,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status Code',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              ChangeNotifierProvider.value(
                value: provider,
                builder: (context, child) {
                  return Consumer<ActivityFilterProvider>(
                    builder: (context, provider, child) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final key = responseStatusCodes.keys.elementAt(index);
                          final isChecked =
                              provider.selectedStatusCodes.contains(key);
                          return CheckboxListTile(
                            value: isChecked,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Row(
                              children: [
                                ContainerLabel(
                                  text: key != null ? '$key' : 'N/A',
                                  color: NetworkInspectorValue.containerColor(
                                    key ?? 0,
                                  ),
                                  textColor: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '(${responseStatusCodes[key]})',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                            onChanged: (isChecked) {
                              provider.onChangeSelectedStatusCode(key ?? 0);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 4,
                          );
                        },
                        itemCount: responseStatusCodes.length,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
              'Apply Filter',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            onPressed: () {
              onTapApplyFilter(provider.selectedStatusCodes);
            },
          ),
        ),
      ],
    );
  }
}
