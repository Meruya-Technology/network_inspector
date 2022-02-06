import 'package:flutter/material.dart';

import '../../domain/entities/http_activity.dart';
import '../widgets/titled_label.dart';

class HttpRequestPage extends StatelessWidget {
  final HttpActivity httpActivity;
  const HttpRequestPage({
    required this.httpActivity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitledLabel(
            title: 'Params',
            content: queryParamsContent(context),
          ),
          const SizedBox(height: 8),
          TitledLabel(
            title: 'Size',
            content: sizeContent(context),
          ),
          const SizedBox(height: 8),
          TitledLabel(
            title: 'Header',
            content: headerContent(context),
          ),
          const SizedBox(height: 8),
          TitledLabel(
            title: 'Body',
            content: bodyContent(context),
          ),
        ],
      ),
    );
  }

  Widget queryParamsContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        httpActivity.request?.params ?? 'N/A',
      ),
    );
  }

  Widget sizeContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${httpActivity.request?.requestSize ?? 0} kb',
      ),
    );
  }

  Widget headerContent(BuildContext context) {
    return Visibility(
      visible: httpActivity.request?.requestHeader != null,
      replacement: const Text('N/A'),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(httpActivity.request?.requestHeader ?? 'N/A'),
      ),
    );
  }

  Widget bodyContent(BuildContext context) {
    return Visibility(
      visible: httpActivity.request?.requestBody != null,
      replacement: const Text('N/A'),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(httpActivity.request?.requestBody ?? 'N/A'),
      ),
    );
  }
}
