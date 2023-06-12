import 'package:flutter/material.dart';

class TitledLabel extends StatelessWidget {
  final String title;
  final String? text;
  final Widget? content;
  const TitledLabel({
    required this.title,
    this.text,
    this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        content ??
            Text(
              text ?? 'N/A',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
      ],
    );
  }
}
