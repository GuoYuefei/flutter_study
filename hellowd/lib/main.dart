
/**
 * 练习一over
 */

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hellowd',
      home: new Scaffold(
        appBar: _buildAppBar(),
        
        body: Center(
          child: Hellowd(),
        )
      ) 
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
        title: new Text('Hello world!'),
      );
  }
}

// StatelessWidge test
class Hellowd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text(
      "Hello world\n" * 2,
      style: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.normal,
        color: Colors.orange
      ),
    );
  }
}
