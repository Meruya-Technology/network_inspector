import 'package:flutter/material.dart';

import '../../common/extensions/json_extension.dart';
import '../../domain/entities/http_activity.dart';
import '../widgets/section_title.dart';

class HttpResponsePage extends StatelessWidget {
  final HttpActivity httpActivity;
  const HttpResponsePage({
    required this.httpActivity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            statusContent(context),
            const SizedBox(height: 8),
            sizeContent(context),
            const SizedBox(height: 8),
            headerContent(context),
            const SizedBox(height: 8),
            bodyContent(context),
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
