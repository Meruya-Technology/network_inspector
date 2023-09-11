import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/byte_extension.dart';
import '../../const/network_inspector_value.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_detail_provider.dart';
import '../widgets/content_container.dart';

/// [HttpRequestPage] is a tab for Request Http Activity, this page is used from
/// [ActivityDetailProvider] to display the request information
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
    final request = httpActivity.request;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentContainer(
              title: 'Query Parameter',
              content: request?.params,
              onCopyTap: () {
                provider.copyActivityData(
                  request?.params ?? NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Query Parameter',
                  request?.params ?? NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Size',
              content: request?.requestSize?.byteToKiloByte(true),
              onCopyTap: () {
                provider.copyActivityData(
                  '${request?.requestSize?.byteToKiloByte(true)}',
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Request Size',
                  '${request?.requestSize?.byteToKiloByte(true)}',
                );
              },
              isJson: false,
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Header',
              content: request?.requestHeader,
              onCopyTap: () {
                provider.copyActivityData(
                  request?.requestHeader ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Request Header',
                  request?.requestHeader ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Body',
              content: request?.requestBody,
              onCopyTap: () {
                provider.copyActivityData(
                  request?.requestBody ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Request Body',
                  request?.requestBody ??
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
