import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/vanilla_provider.dart';

class VanillaPage extends StatelessWidget {
  static const String routeName = '/vanilla-page';
  const VanillaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VanillaProvider(
        context: context,
      ),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Vanilla http inspection'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Planet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Create http activity using planet data',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            ListTile(
              title: const Text('Get'),
              subtitle: Text(
                'Create http activity with method GET',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Post'),
              subtitle: Text(
                'Create http activity with method POST',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Put'),
              subtitle: Text(
                'Create http activity with method PUT',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Delete'),
              subtitle: Text(
                'Create http activity with method DELETE',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
