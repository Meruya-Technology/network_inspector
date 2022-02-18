import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/json_extension.dart';
import '../../const/network_inspector_value.dart';
import '../../domain/entities/http_activity.dart';
import '../controllers/activity_detail_provider.dart';
import '../widgets/content_container.dart';
import '../widgets/section_title.dart';

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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentContainer(
              title: 'Response Status',
              content: (httpActivity.response?.responseStatusCode != null)
                  ? '${httpActivity.response?.responseStatusCode} '
                      '${httpActivity.response?.responseStatusMessage}'
                  : null,
              isJson: false,
              onCopyTap: () {
                provider.copyActivityData(
                  (httpActivity.response?.responseStatusCode != null)
                      ? '${httpActivity.response?.responseStatusCode} '
                          '${httpActivity.response?.responseStatusMessage}'
                      : NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Response Status',
                  (httpActivity.response?.responseStatusCode != null)
                      ? '${httpActivity.response?.responseStatusCode} '
                          '${httpActivity.response?.responseStatusMessage}'
                      : NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Size',
              content: '${httpActivity.response?.responseSize ?? 0} kb',
              onCopyTap: () {
                provider.copyActivityData(
                  '${httpActivity.response?.responseSize ?? 0} kb',
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Response Size',
                  '${httpActivity.response?.responseSize ?? 0} kb',
                );
              },
              isJson: false,
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Header',
              content: httpActivity.response?.responseHeader,
              onCopyTap: () {
                provider.copyActivityData(
                  httpActivity.response?.responseHeader ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Header',
                  httpActivity.response?.responseHeader ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
            const SizedBox(height: 8),
            ContentContainer(
              title: 'Body',
              content: httpActivity.response?.responseBody,
              onCopyTap: () {
                provider.copyActivityData(
                  httpActivity.response?.responseBody ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
              onShareTap: () {
                provider.shareActivityData(
                  'Body',
                  httpActivity.response?.responseBody ??
                      NetworkInspectorValue.defaultEmptyString,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget statusContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Response Status',
          onCopyTap: () {},
          onShareTap: () {},
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            (httpActivity.response?.responseStatusCode != null)
                ? '${httpActivity.response?.responseStatusCode} '
                    '${httpActivity.response?.responseStatusMessage}'
                : 'N/A',
          ),
        ),
      ],
    );
  }

  Widget sizeContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Size',
          onCopyTap: () {},
          onShareTap: () {},
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${httpActivity.response?.responseSize ?? 0} kb',
          ),
        ),
      ],
    );
  }

  Widget headerContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Header',
          onCopyTap: () {},
          onShareTap: () {},
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(httpActivity.response?.responseHeader?.prettify ?? 'N/A'),
        ),
      ],
    );
  }

  Widget bodyContent(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'Body',
          onCopyTap: () {},
          onShareTap: () {},
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.maxFinite,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              httpActivity.response?.responseBody.prettify ?? 'N/A',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ],
    );
  }
}
