import 'package:flutter/material.dart';
import 'package:network_inspector/const/network_inspector_value.dart';
import 'package:network_inspector/presentation/controllers/activity_detail_provider.dart';
import 'package:network_inspector/presentation/widgets/content_container.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/http_activity.dart';
import '../widgets/section_title.dart';

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
