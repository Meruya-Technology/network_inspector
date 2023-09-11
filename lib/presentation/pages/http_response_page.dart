import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/byte_extension.dart';
import '../../const/network_inspector_value.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_detail_provider.dart';
import '../widgets/content_container.dart';

/// [HttpResponsePage] is a tab for Http Response Activity, this page is used
/// from [ActivityDetailProvider] to display the error information
class HttpResponsePage extends StatelessWidget {
  final HttpActivity httpActivity;
  const HttpResponsePage({
    required this.httpActivity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityDetailProvider>(
      context,
      listen: false,
    );
    final response = httpActivity.response;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentContainer(
              title: 'Response Status',
              content: (response?.responseStatusCode != null)
                  ? '${response?.responseStatusCode} '
                      '${response?.responseStatusMessage}'
                  : null,
              isJson: false,
              onCopyTap: () {
                provider.copyActivityData(
                  (response?.responseStatusCode != null)
                      ? '${response?.responseStatusCode} '
                          '${response?.responseStatusMessage}'
                      : NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Response Status',
                  (response?.responseStatusCode != null)
                      ? '${response?.responseStatusCode} '
                          '${response?.responseStatusMessage}'
                      : NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Size',
              content: response?.responseSize?.byteToKiloByte(true),
              onCopyTap: () {
                provider.copyActivityData(
                  '${response?.responseSize?.byteToKiloByte(true)}',
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Response Size',
                  '${response?.responseSize?.byteToKiloByte(true)}',
                );
              },
              isJson: false,
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Header',
              content: response?.responseHeader,
              onCopyTap: () {
                provider.copyActivityData(
                  response?.responseHeader ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Header',
                  response?.responseHeader ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Body',
              content: response?.responseBody,
              onCopyTap: () {
                provider.copyActivityData(
                  response?.responseBody ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Body',
                  response?.responseBody ??
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
