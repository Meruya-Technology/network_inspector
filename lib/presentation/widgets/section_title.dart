import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onShareTap;
  final VoidCallback? onCopyTap;
  const SectionTitle({
    required this.title,
    this.onShareTap,
    this.onCopyTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: onShareTap,
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                Icons.share,
                size: 18,
              ),
            ),
            IconButton(
              onPressed: onCopyTap,
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                Icons.copy,
                size: 18,
              ),
            )
          ],
        ),
      ],
    );
  }
}
