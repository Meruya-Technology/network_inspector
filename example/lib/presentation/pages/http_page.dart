import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/http_provider.dart';

class HttpPage extends StatelessWidget {
  static const String routeName = '/http-page';
  const HttpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HttpProvider(
        context: context,
      ),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text('Http inspection'),
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
      ),
    );
  }
}
