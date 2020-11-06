import 'package:MyFlutter/network/http_dio.dart';
import 'package:MyFlutter/network/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Explore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExploreState();
  }
}

class ExploreState extends State<Explore> {
  // 输入框控制器
  final TextEditingController searchController = TextEditingController();
  // 焦点控制
  final FocusNode searchFocusNode = FocusNode();

  // 搜索后的用来显示的稳步
  var contentText = '';

  void search(String text, BuildContext buildContext) {
    showToast("搜索$text",
        context: buildContext, position: StyledToastPosition.center);
    HttpDio().dio.post(Url.search(0), data: {
      'k': text,
    }).then((value) {
      print(value);
      setState(() {
        contentText = value.toString();
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              maxLength: 30,
              maxLines: 1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: searchController,
              focusNode: searchFocusNode,
              onEditingComplete: () {
                searchFocusNode.unfocus();
                search(searchController.text, context);
              },
              decoration: InputDecoration(
                  border: InputBorder.none, //去掉输入框的下滑线
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "搜索一下",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: null,
                  disabledBorder: null),
            ),
            Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(contentText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
