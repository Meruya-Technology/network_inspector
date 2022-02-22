import 'package:flutter/material.dart';

import '../../common/change_notifier_page.dart';
import '../controllers/http_provider.dart';

class HttpPage extends ChangeNotifierPage<HttpProvider> {
  static const String routeName = '/http-page';

  const HttpPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http inspection'),
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
              provider(context).fetchPlanet!.execute();
            },
          ),
          ListTile(
            title: const Text('Post'),
            subtitle: Text(
              'Create http activity with method POST',
              style: Theme.of(context).textTheme.caption,
            ),
            onTap: () {
              provider(context).createPlanet!.execute(
                    name: 'Earth',
                    description: 'Our Home',
                  );
            },
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
    );
  }

  @override
  HttpProvider create(BuildContext context) => HttpProvider(context: context);
}
