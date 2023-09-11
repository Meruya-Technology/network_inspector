import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/network_inspector_value.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_detail_provider.dart';
import '../widgets/content_container.dart';

/// [HttpErrorPage] is a tab for Error Http Activity, this page is used from
/// [ActivityDetailProvider] to display the error information
class HttpErrorPage extends StatelessWidget {
  final HttpActivity httpActivity;
  const HttpErrorPage({
    required this.httpActivity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: errorContent(context),
    );
  }

  Widget errorContent(BuildContext context) {
    final provider = Provider.of<ActivityDetailProvider>(
      context,
      listen: false,
    );
    return Container(
      margin: const EdgeInsets.all(16),
      child: ContentContainer(
        title: 'Error Log',
        content: httpActivity.response?.errorLog,
        isJson: false,
        onCopyTap: () {
          provider.copyActivityData(
            httpActivity.response?.errorLog ??
                NetworkInspectorValue.defaultEmptyString,
          );
        },
        onShareTap: () {
          provider.shareActivityData(
            'Error Log',
            httpActivity.response?.errorLog ??
                NetworkInspectorValue.defaultEmptyString,
          );
        },
      ),
    );
  }
}
