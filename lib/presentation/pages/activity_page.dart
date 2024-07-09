import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../common/base/data_wrapper.dart';
import '../../common/extensions/unix_extension.dart';
import '../../common/extensions/url_extension.dart';
import '../../common/formatters/ip_input_formatter.dart';
import '../../common/utils/byte_util.dart';
import '../../common/utils/date_time_util.dart';
import '../../common/widgets/bottom_sheet.dart';
import '../../const/network_inspector_value.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_provider.dart';
import '../widgets/container_label.dart';
import '../widgets/filter_bottom_sheet_content.dart';

/// A page that show list of logged HTTP Activities, for navigating to this
/// page use regular Navigator.push
/// ```dart
///  Navigator.push(
///   context,
///   MaterialPageRoute<void>(
///     builder: (context) => ActivityPage(),
///   ),
/// );
/// ```
class ActivityPage extends StatelessWidget {
  static const String routeName = '/http-activity';

  ActivityPage({
    super.key,
  });

  final _byteUtil = ByteUtil();
  final _dateTimeUtil = DateTimeUtil();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityProvider>(
      create: (context) => ActivityProvider(
        context: context,
      ),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Http Activities'),
          actions: [
            IconButton(
              onPressed: () {
                onTapFilterIcon(context);
              },
              icon: const Icon(
                Icons.filter_list_alt,
              ),
            ),
            IconButton(
              onPressed: () {
                final provider = context.read<ActivityProvider>();
                provider.deleteActivities();
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Consumer<ActivityProvider>(
                builder: (context, provider, child) {
                  final result = provider.fetchedActivity;
                  switch (provider.fetchedActivity.status) {
                    case Status.loading:
                      return loadingWidget(context);
                    case Status.success:
                      return successBody(
                        context,
                        result.data,
                      );
                    case Status.error:
                      return errorMessage(context, result.message);
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          Consumer<ActivityProvider>(
            builder: (context, provider, child) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  border: Border(
                    top: BorderSide(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.new_releases),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'New Feature !',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Inspect network straight from your PC with '
                        'Beyond Socket and Beyond Console',
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: provider.ipInputController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'required';
                                }
                                return null;
                              },
                              inputFormatters: [
                                IpInputFormatter(),
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Web socket server IP',
                                suffixIcon:
                                    ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: provider.ipInputController,
                                  builder: (context, value, child) =>
                                      Visibility(
                                    visible: (value.text.isNotEmpty),
                                    child: IconButton(
                                      onPressed: provider.onIpInputClear,
                                      icon: const Icon(
                                        Icons.clear,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: provider.portInputController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'required';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              decoration: const InputDecoration(
                                filled: true,
                                hintText: 'Port',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: provider.serverIdInputController,
                        textInputAction: TextInputAction.go,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Server ID',
                          suffixIcon: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: provider.serverIdInputController,
                            builder: (context, value, child) => Visibility(
                              visible: (value.text.isNotEmpty),
                              child: IconButton(
                                onPressed: provider.onIpInputClear,
                                icon: const Icon(
                                  Icons.clear,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// TODO: UNRELEASED FEATURE
                          // FilledButton.tonalIcon(
                          //   onPressed: () {},
                          //   label: const Text(
                          //     'Scan QR',
                          //   ),
                          //   icon: const Icon(
                          //     Icons.qr_code_scanner_outlined,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 12,
                          // ),
                          FilledButton(
                            onPressed: () {
                              provider.disconnect();
                            },
                            child: const Text(
                              'Connect',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget successBody(
    BuildContext context,
    List<HttpActivity>? data,
  ) {
    return Visibility(
      visible: data?.isNotEmpty ?? false,
      replacement: emptyBody(context),
      child: activityList(context, data),
    );
  }

  Widget emptyBody(BuildContext context) {
    return Center(
      child: Text(
        'There is no log, try to fetch something !',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget errorMessage(BuildContext context, error) {
    return Center(
      child: Text(
        'Log has error $error',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget loadingWidget(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget idleWidget(BuildContext context) {
    return Center(
      child: Text(
        'Please wait',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget activityList(
    BuildContext context,
    List<HttpActivity>? data,
  ) {
    return ListView.separated(
      itemCount: data?.length ?? 0,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => activityTile(
        context,
        data![index],
        index,
      ),
    );
  }

  Widget activityTile(
    BuildContext context,
    HttpActivity activity,
    int index,
  ) {
    return ListTile(
      onTap: () {
        var provider = context.read<ActivityProvider>();
        provider.goToDetailActivity(activity);
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '${activity.request?.method} '
              '${activity.request?.path ?? '-'}',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ContainerLabel(
            text: '${activity.response?.responseStatusCode ?? 'N/A'}',
            color: NetworkInspectorValue.containerColor(
              activity.response?.responseStatusCode ?? 0,
            ),
            textColor: Colors.white,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Visibility(
                visible: activity.request?.baseUrl?.isSecure ?? false,
                replacement: const Icon(
                  Icons.lock_open,
                  size: 18,
                  color: Colors.grey,
                ),
                child: const Icon(
                  Icons.lock,
                  size: 18,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: Text(
                  activity.request?.baseUrl ?? '-',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                activity.request?.createdAt?.convertToYmdHms ?? '-',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                _byteUtil.totalTransferSize(
                  activity.request?.requestSize,
                  activity.response?.responseSize,
                  false,
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                _dateTimeUtil.milliSecondDifference(
                  activity.request?.createdAt,
                  activity.response?.createdAt,
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onTapFilterIcon(BuildContext context) {
    final provider = context.read<ActivityProvider>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetTemplate(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: FilterBottomSheetContent(
              responseStatusCodes: provider.statusCodes,
              onTapApplyFilter: (list) {
                Navigator.pop(context);
                provider.filterHttpActivities(list);
              },
              provider: provider.filterProvider!,
            ),
          ),
        );
      },
    );
  }
}
