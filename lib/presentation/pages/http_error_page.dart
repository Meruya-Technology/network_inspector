import 'package:flutter/material.dart';
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
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Error Log',
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
              httpActivity.response?.errorLog ?? 'N/A',
            ),
          ),
        ],
      ),
    );
  }
}
