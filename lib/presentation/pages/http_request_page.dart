import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/network_inspector_value.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_detail_provider.dart';
import '../widgets/content_container.dart';

class HttpRequestPage extends StatelessWidget {
  final HttpActivity httpActivity;
  const HttpRequestPage({
    required this.httpActivity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityDetailProvider>(
      context,
      listen: false,
    );
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentContainer(
              title: 'Query Parameter',
              content: httpActivity.request?.params,
              onCopyTap: () {
                provider.copyActivityData(
                  httpActivity.request?.params ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Query Parameter',
                  httpActivity.request?.params ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Size',
              content: '${httpActivity.request?.requestSize ?? 0} kb',
              onCopyTap: () {
                provider.copyActivityData(
                  '${httpActivity.request?.requestSize ?? 0} kb',
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Request Size',
                  '${httpActivity.request?.requestSize ?? 0} kb',
                );
              },
              isJson: false,
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Header',
              content: httpActivity.request?.requestHeader,
              onCopyTap: () {
                provider.copyActivityData(
                  httpActivity.request?.requestHeader ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Request Header',
                  httpActivity.request?.requestHeader ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Body',
              content: httpActivity.request?.requestBody,
              onCopyTap: () {
                provider.copyActivityData(
                  httpActivity.request?.requestBody ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Request Body',
                  httpActivity.request?.requestBody ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
