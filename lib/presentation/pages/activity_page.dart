import 'package:flutter/material.dart';
import 'package:network_inspector/domain/entities/activity.dart';
import 'package:network_inspector/presentation/controllers/activity_provider.dart';
import 'package:provider/provider.dart';

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
          title: Text('Activities'),
        ),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Consumer<ActivityProvider>(
        builder: (context, provider, child) => FutureBuilder<List<Activity>?>(
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
    List<Activity> data,
  ) {
    return Visibility(
      visible: data.isNotEmpty,
      child: Text('We have the data'),
      replacement: emptyBody(context),
    );
  }

  Widget emptyBody(BuildContext context) {
    return Center(
      child: Text('There is no log, try to fetch something !'),
    );
  }

  Widget errorMessage(BuildContext context, error) {
    return Center(
      child: Text('Log has error $error'),
    );
  }

  Widget loadingWidget(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget idleWidget(BuildContext context) {
    return Center(
      child: Text('Please wait'),
    );
  }
}
