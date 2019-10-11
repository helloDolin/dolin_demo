import 'package:flutter/material.dart'; // 导入 Material UI组件库
import 'package:flutter/services.dart';

// 应用入口，所以MyApp是应用的根组件
void main() => runApp(MyApp());

//void main() {
//  runApp(MyApp()); 上面为单行函数的简写
//}

class MyApp extends StatelessWidget {
  // widget的主要作用是提供一个build()方法来描述如何构建UI页面
  @override
  Widget build(BuildContext context) {
    // MaterialApp 是Material库中提供的Flutter App 框架，可以设置应用名称、主题、语言、路由表等
    return MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      // 名为"/"的路由作为应用的首页
      initialRoute: '/',

      // 路由表注册
      routes: {
        // 注册首页路由
        "/":(context) => MyHomePage(title: 'Flutter Demo Home Page'),
        "new_route":(context){
          return NewRoute(text: ModalRoute.of(context).settings.arguments);
        },
      },
//      home: MyHomePage(title: 'Flutter Demo Home Page 123'),
    );
  }
}


/*
* StatefulWidget 至少由两个类组成
* StatefulWidget 类
* State 类
* 注意 build 方法被绑到了 _MyHomePageState 中
* */
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // 原注释
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.lightBlue,
              onPressed: () async {
                var result = await Navigator.pushNamed(context, "new_route",arguments: "hello");
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context){
//                        return NewRoute(
//                          text: "NewRoute",
//                        );
//                      },
//                      fullscreenDialog: false,
//                    )
//                );
                print("路由返回值：$result");
              },
            )
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add_a_photo),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  NewRoute({
    Key key,
    @required this.text // 接收 text 参数
  }):super(key:key);
  final String text;

  @override
  Widget build(BuildContext context) {
    // Scaffold 为 Material库中提供的页面脚手架，包含导航栏和Body以及FloatingActionButton
    return Scaffold(
      appBar: AppBar(
        title:Text("New route"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("上个页面传过来的值：$text"),
              RaisedButton(
                onPressed: () => Navigator.pop(context,"New route"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

