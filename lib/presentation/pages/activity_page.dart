import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/unix_extension.dart';
import '../../common/extensions/url_extension.dart';
import '../../common/utils/byte_util.dart';
import '../../common/utils/date_time_util.dart';
import '../../const/network_inspector_value.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_provider.dart';
import '../widgets/container_label.dart';

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

  ActivityPage({Key? key}) : super(key: key);

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
                var provider = context.read<ActivityProvider>();
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
    return Container(
      padding: const EdgeInsets.all(8),
      child: Consumer<ActivityProvider>(
        builder: (context, provider, child) =>
            FutureBuilder<List<HttpActivity>?>(
          future: provider.fetchedActivity,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return doneWidget(context, snapshot);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingWidget(context);
            } else {
              return idleWidget(context);
            }
          },
        ),
      ),
    );
  }

  Widget doneWidget(BuildContext context, AsyncSnapshot snapshot) {
    return Visibility(
      visible: snapshot.hasData,
      replacement: errorMessage(context, snapshot.error),
      child: successBody(context, snapshot.data),
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
    return const Center(
      child: Text('There is no log, try to fetch something !'),
    );
  }

  Widget errorMessage(BuildContext context, error) {
    return Center(
      child: Text('Log has error $error'),
    );
  }

  Widget loadingWidget(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget idleWidget(BuildContext context) {
    return const Center(
      child: Text('Please wait'),
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
              style: Theme.of(context).textTheme.bodyText1,
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
                  style: Theme.of(context).textTheme.bodyText2,
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
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                _byteUtil.totalTransferSize(
                  activity.request?.requestSize,
                  activity.response?.responseSize,
                  false,
                ),
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                _dateTimeUtil.milliSecondDifference(
                  activity.request?.createdAt,
                  activity.response?.createdAt,
                ),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
