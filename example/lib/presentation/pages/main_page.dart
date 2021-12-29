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
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityPage(),
                  ),
                );
              },
              child: Text('Activity page'),
            ),
          ],
        ),
      ),
    );
  }
}
