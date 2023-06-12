import 'package:flutter/material.dart';

import 'dio_page.dart';
import 'http_page.dart';
import 'vanilla_page.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/main-page';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Inspector'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Json',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Create Http Activity with Json payload',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          ListTile(
            title: const Text('Dio'),
            subtitle: Text(
              'Create http activity with Dio package',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              Navigator.pushNamed(context, DioPage.routeName);
            },
          ),
          ListTile(
            title: const Text('Http'),
            subtitle: Text(
              'Create http activity with http package',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              Navigator.pushNamed(context, HttpPage.routeName);
            },
          ),
          ListTile(
            title: const Text('Http vanilla'),
            subtitle: Text(
              'Create http activity with vanilla http client (io/http)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              Navigator.pushNamed(context, VanillaPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
