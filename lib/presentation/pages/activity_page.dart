import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/date_util.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_provider.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityProvider>(
      create: (context) => ActivityProvider(
        context: context,
      ),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Activities'),
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
      child: successBody(context, snapshot.data),
      replacement: errorMessage(context, snapshot.error),
    );
  }

  Widget successBody(
    BuildContext context,
    List<HttpActivity>? data,
  ) {
    return Visibility(
      visible: data?.isNotEmpty ?? false,
      child: activityList(context, data),
      replacement: emptyBody(context),
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
      itemBuilder: (context, index) => ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                data![index].request?.url ?? '-',
              ),
            ),
            Text(
              data[index].request?.method ?? '-',
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data[index].response?.responseStatusCode ?? '-'}',
            ),
            Text(
              data[index].request?.createdAt?.convertToYmdHms ?? '-',
            ),
          ],
        ),
      ),
    );
  }
}
