import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "what's your favorite picture: ",
            style: Theme.of(context).textTheme.title,
          ),
        ),
        body: PhotoDisplay());
  }
}

class PhotoDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotoDisplayState(17);
  }
}

class PhotoDisplayState extends State<PhotoDisplay> {
  IconData icon1 = Icons.favorite_border;
  IconData icon2 = Icons.favorite_border;
  Image image1, image2; 
  int pNum = 0;
  List<int> plist = [];
  PhotoDisplayState(int pnum) {
    this.pNum = pnum;
    for(int i = 0; i < pnum; i++) {
      plist.add(3);
    }
    image1 = PhotoDisplayState._randomPicture(pNum);
    image2 = PhotoDisplayState._randomPicture(pNum);    
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 6),
                  child: image1,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: _pressFavi1,
                    child: Icon(icon1),
                  ),
                )),
            Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 6),
                  child: image2,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: _pressFavi2,
                    child: new Icon(icon2),
                  ),
                ))
          ],
        )
      ],
    );
  }

  IconData _pressFavi(IconData icon) {
    if (icon == Icons.favorite_border) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }

  //点击爱心之后的效果
  void _pressFavi1() {
    if(icon2 == Icons.favorite) return;    //两者不能同时喜欢
    setState(() {
      icon1 = _pressFavi(icon1);
      image1 = _randomPicture(pNum, 
        exception: image2,
      );
    });
  }

  void _pressFavi2() {
    if(icon1 == Icons.favorite) return;
    setState(() {
          icon2 = _pressFavi(icon2);
    });
  }

  //需要一个随机加载图片的函数
  static Image _randomPicture(int pnum, {Image exception = null}) {
    //TODO 先完成随机加载图片
    var random = Random();
    int tempI = random.nextInt(pnum) + 1;
    Image igs = Image(
      image: AssetImage('assets/images/$tempI.jpg')
    );
    // TODO 不能使用这种方式消除重复图片
    while(igs == exception) {
      tempI = random.nextInt(pnum) + 1;
      igs = Image(
        image: AssetImage('assets/images/$tempI.jpg')
      );
    }
    return igs;
  }
}
