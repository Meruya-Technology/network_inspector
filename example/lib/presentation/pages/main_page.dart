import 'package:flutter/material.dart';
import 'package:network_inspector/presentation/pages/activity_page.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/main-page';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Inspector'),
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
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Create Http Activity with Json payload',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('Get'),
            subtitle: Text(
              'Create http activity with method GET',
              style: Theme.of(context).textTheme.caption,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Post'),
            subtitle: Text(
              'Create http activity with method POST',
              style: Theme.of(context).textTheme.caption,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Put'),
            subtitle: Text(
              'Create http activity with method PUT',
              style: Theme.of(context).textTheme.caption,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Delete'),
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
}
