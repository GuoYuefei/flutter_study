import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

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

// 记录图片id的拓展类
class IDImage extends Image {
  int _id;
  IDImage(int id, ImageProvider image) : super(image: image){
    this._id = id;
  }
  get id => _id;
}


class PhotoDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotoDisplayState(17);
  }
}

class PhotoDisplayState extends State<PhotoDisplay> {
  static const int compare_num = 3;  
  int _nowNum = 1;   
  final Icon iconState0 = new Icon(Icons.favorite_border);
  final Icon iconState1 = new Icon(
    Icons.favorite,
    color: Colors.red,
  );
  Function _twoTimer;
  Timer timer;      //记录_twoTimer返回的timer
  Icon icon1, icon2;
  IDImage image1, image2;
  int pNum = 0;
  List<int> plist = [];

  // TODO 用于记录此次用户选择喜爱照片的情况
  Map<int, int> favi = new Map<int, int>();

  //记录的函数
  //这个函数应该放入计时器的回调函数中调用
  void _record() {
    int id;
    //如果icon1是喜欢状态那么就记录下图片1，否则
    id = iconState1 == icon1 ? image1.id : image2.id;
    //如果不是第一次喜欢该图片的话就计数加一
    if(favi.containsKey(id)) {
      favi[id]++;
      return;
    }
    //第一次喜欢就将此id作为key放入map中
    favi.putIfAbsent(id, ()=>1);
  }


  PhotoDisplayState(int pnum) {
    
    this.pNum = pnum;
    for (int i = 0; i < pnum; i++) {
      plist.add(3);
    }
    icon1 = iconState0;
    icon2 = iconState0;

    image1 = PhotoDisplayState._randomPicture(pNum);
    image2 = PhotoDisplayState._randomPicture(pNum, 
      exceptions: [image1],
    );

    //该函数生成一个两秒的定时
    _twoTimer = () => new Timer(Duration(seconds:2), this._refresh);    
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
                    child: icon1,
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
                    child: icon2,
                  ),
                ))
          ],
        )
      ],
    );
  }

  Icon _pressFavi(Icon icon) {
    if (icon == this.iconState0) {
      timer = _twoTimer();    //重新生成计时器
      return this.iconState1;
    } else {
      timer.cancel();
      return this.iconState0;
    }
  }

  //点击爱心1之后的效果
  void _pressFavi1() {
    //两者不能同时喜欢
    if (icon2 == this.iconState1) {
      timer.cancel();
      setState(() {
        icon2 = this.iconState0;            
      });
    }
    setState(() {
      icon1 = _pressFavi(icon1);
    });

    // _refresh();
  }

  //点击爱心1之后的效果
  void _pressFavi2() {
    //两者不能同时喜欢
    if (icon1 == this.iconState1) {
      timer.cancel();
      setState(() {
        icon1 = this.iconState0;            
      });
    }
    setState(() {
      icon2 = _pressFavi(icon2);
    });

    // _refresh();
  }

  //需要一个随机加载图片的函数
  // TODO 机率调节
  static IDImage _randomPicture(int pnum, {List<IDImage> exceptions}) {
    String pictroot = 'assets/images/';
    var random = Random();
    int tempI;
    bool flag = false;
    do {
      flag = false;
      tempI = random.nextInt(pnum) + 1;
      if (exceptions == null) break;
      for (IDImage i in exceptions) {
        if ((i.image as AssetImage).assetName == pictroot + '$tempI.jpg') {
          flag = true;
          break;
        }
      }
    } while (flag);
    return IDImage(tempI, AssetImage(pictroot + '$tempI.jpg'));
  }

  //TODO 切换页面 这个不用路由实现，在选择完喜欢的照片后不能再退回之前的状态了。
  //选择完喜欢照片后两秒内自动跳转，若此时取消喜欢就取消定时跳转
  void _refresh() {
    //刷新之前需要记录用户喜欢哪张图片
    _record();

    //主要是两张图片的刷新
    setState(() {
      if(_nowNum == compare_num) {
        //如果没达到设置的比较上限
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => Preference()), (Route r) => true);
      } else {
        _nowNum++;   //比较次数加一
        image1 = _randomPicture(pNum, exceptions: [image1, image2]);

        image2 = _randomPicture(pNum, exceptions: [image1, image2]);

        icon1 = this.iconState0;
        icon2 = this.iconState0;
      }
    });
  }
}


//显示页面需要一个不一样的wigets
class Preference extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PreferenceState();
  }

}

class PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text("1111111111");
  }



}
