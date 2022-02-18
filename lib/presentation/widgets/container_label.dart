import 'package:flutter/material.dart';

class ContainerLabel extends StatelessWidget {
  final String? text;
  final Color color;
  final Color textColor;
  const ContainerLabel({
    this.text,
    this.color = Colors.grey,
    this.textColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Text(
        text ?? 'N/A',
        style: Theme.of(context).textTheme.caption?.copyWith(color: textColor),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
    );
  }
}
