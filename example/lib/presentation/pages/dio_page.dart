import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/dio_provider.dart';

class DioPage extends StatelessWidget {
  static const String routeName = '/dio-page';
  const DioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DioProvider(
        context: context,
      ),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Dio inspection'),
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
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'Create http activity using planet data',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            ListTile(
              title: const Text('Get'),
              subtitle: Text(
                'Create http activity with method GET',
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () {
                var provider = Provider.of<DioProvider>(context, listen: false);
                provider.fetchPlanet!.execute();
              },
            ),
            ListTile(
              title: const Text('Post'),
              subtitle: Text(
                'Create http activity with method POST',
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Put'),
              subtitle: Text(
                'Create http activity with method PUT',
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Delete'),
              subtitle: Text(
                'Create http activity with method DELETE',
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
