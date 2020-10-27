import 'package:MyFlutter/page/explore.dart';
import 'package:MyFlutter/page/home.dart';
import 'package:MyFlutter/page/home_doc.dart';
import 'package:MyFlutter/page/padge_config.dart';
import 'package:MyFlutter/page/user.dart';
import 'package:MyFlutter/page/user_login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

const bottomItems = [
  BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
  BottomNavigationBarItem(icon: Icon(Icons.assessment), title: Text("发现")),
  BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
];

final pages = [
  Home(),
  Explore(),
  User(),
];

class MainApp extends StatelessWidget {
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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        PageConfig.homeDoc: (context) => HomeDoc(),
        PageConfig.userLogin: (context) => UserLogin(),
      },
      home: MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MainState createState() => MainState();
}

class MainState extends State<MainPage> {
  int currentIndex = 0;

  /// 切换页面
  changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomItems,
        currentIndex: currentIndex,
        onTap: (index) {
          changePage(index);
        },
      ),
    );
  }
}
