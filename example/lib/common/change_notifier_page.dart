import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class ChangeNotifierPage<T extends ChangeNotifier>
    extends StatelessWidget {
  final Widget? child;

  const ChangeNotifierPage({
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => create(context),
      builder: (context, child) {
        return buildWidget(context, child);
      },
      child: child,
    );
  }

  Widget buildWidget(BuildContext context, Widget? child);

  T provider(BuildContext context) => Provider.of<T>(context, listen: false);

  T create(BuildContext context);
}
