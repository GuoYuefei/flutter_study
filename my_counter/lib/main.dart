import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Counter(),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CounterState();

}

class CounterState extends State<Counter> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('counter by myself'),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text(
              'the counter is: ', 
              style: Theme.of(context).textTheme.headline,
              ),
            new Text(
            '$counter',
            style: Theme.of(context).textTheme.display1,
            ),
            new RaisedButton(
              child: Icon(Icons.lens),
              onPressed: () => setState(() => counter--)
              ,
            ),
            new FlatButton(
              child: Icon(Icons.open_in_new),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NewRouter();
                  }
                ));
              },
            )
          ],
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: increCounter,
        child: new Icon(Icons.add),
      ),
    );
  }

  //增加counter
  void increCounter() {
    setState(() {
      counter++;   
    });
  }

}

class NewRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('New Router'),
      ),
      body: Center(
        child: Text('This is new route'),
      ),
    );
  }

}

