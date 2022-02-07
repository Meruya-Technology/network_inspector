import 'package:flutter/material.dart';

import '../../common/extensions/json_extension.dart';
import '../../domain/entities/http_activity.dart';
import '../widgets/section_title.dart';

class HttpRequestPage extends StatelessWidget {
  final HttpActivity httpActivity;
  const HttpRequestPage({
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
            queryParamsContent(context),
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

  Widget queryParamsContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Query Parameter',
          onCopyTap: () {},
          onShareTap: () {},
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            httpActivity.request?.params.prettify ?? 'N/A',
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
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${httpActivity.request?.requestSize ?? 0} kb',
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
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(httpActivity.request?.requestHeader?.prettify ?? 'N/A'),
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
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              httpActivity.request?.requestBody.prettify ?? 'N/A',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ],
    );
  }
}
