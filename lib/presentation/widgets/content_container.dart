import 'package:flutter/material.dart';
import '../../common/extensions/json_extension.dart';
import 'section_title.dart';

class ContentContainer extends StatelessWidget {
  final String title;
  final String? content;
  final VoidCallback? onShareTap;
  final VoidCallback? onCopyTap;
  final bool isJson;

  const ContentContainer({
    required this.title,
    this.content,
    this.onShareTap,
    this.onCopyTap,
    this.isJson = true,
    Key? key,
  }) : super(key: key);

  /// This constant is used for replacing string when content is missing / null
  static const String defaultEmptyContent = 'N/A';

  /// When isJson is true, the content will be using Extension `prettify` which
  /// has default empty value 'N/A', but when isJson is false the default value
  /// is using `defaultEmptyContent` constant.
  String get processedContent {
    final nonJsonContent = (content ?? defaultEmptyContent);
    return (isJson) ? content.prettify : nonJsonContent;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: title,
          isVisible: content != null,
          onCopyTap: onCopyTap,
          onShareTap: onShareTap,
        ),
        Scrollbar(
          child: Material(
            color: (Theme.of(context).brightness == Brightness.dark)
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.25),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  processedContent,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
