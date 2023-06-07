import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/network_inspector_enum.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_detail_provider.dart';
import '../widgets/titled_label.dart';
import 'http_error_page.dart';
import 'http_request_page.dart';
import 'http_response_page.dart';

class ActivityDetailPage extends StatelessWidget {
  static const String routeName = '/http-activity-detail';

  final HttpActivity httpActivity;
  const ActivityDetailPage({
    required this.httpActivity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityDetailProvider>(
      create: (context) => ActivityDetailProvider(
        httpActivity: httpActivity,
        context: context,
      ),
      builder: (context, child) {
        final provider = context.read<ActivityDetailProvider>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Http Activity'),
            actions: [
              IconButton(
                onPressed: () {
                  provider.buildJson(
                    provider.shareHttpActivity,
                    HttpActivityActionType.share,
                  );
                },
                icon: const Icon(
                  Icons.share,
                ),
              ),
              IconButton(
                onPressed: () {
                  provider.buildJson(
                    provider.copyHttpActivity,
                    HttpActivityActionType.copy,
                  );
                },
                icon: const Icon(
                  Icons.copy,
                ),
              ),
            ],
          ),
          body: buildBody(context),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyHeader(context),
          bodyContent(context),
        ],
      ),
    );
  }

  Widget bodyHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: (Theme.of(context).brightness == Brightness.dark)
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitledLabel(
                title: 'Url',
                text: httpActivity.request?.baseUrl,
              ),
              const SizedBox(height: 8),
              TitledLabel(
                title: 'Path',
                text: httpActivity.request?.path,
              ),
            ],
          ),
        ),
        TabBar(
          labelStyle: Theme.of(context).textTheme.labelLarge,
          labelColor: Theme.of(context).colorScheme.onBackground,
          indicatorColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.surface,
          tabs: [
            Tab(
              child: Text(
                'Request',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Tab(
              child: Text(
                'Response',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Tab(
              child: Text(
                'Error',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bodyContent(BuildContext context) {
    return Expanded(
      child: Consumer<ActivityDetailProvider>(
        builder: (context, provider, child) => TabBarView(
          children: [
            HttpRequestPage(
              httpActivity: httpActivity,
            ),
            HttpResponsePage(
              httpActivity: httpActivity,
            ),
            HttpErrorPage(
              httpActivity: httpActivity,
            ),
          ],
        ),
      ),
    );
  }
}
