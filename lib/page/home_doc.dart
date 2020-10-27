import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeDoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var argMap = ModalRoute.of(context).settings.arguments as Map;
    print(argMap);
    return Scaffold(
      appBar: AppBar(
        title: Text(argMap['title']),
      ),
      body: Container(
          child: WebView(
            initialUrl: argMap['link'],
            javascriptMode: JavascriptMode.unrestricted,
          ) ,
      ),
    );
  }
}
