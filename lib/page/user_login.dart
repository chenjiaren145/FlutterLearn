import 'package:MyFlutter/bean/registered_entity.dart';
import 'package:MyFlutter/config/app_status.dart';
import 'package:MyFlutter/network/http_dio.dart';
import 'package:MyFlutter/network/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class UserLogin extends StatefulWidget {
  @override
  UserLoginState createState() => new UserLoginState();
}

class UserLoginState extends State<UserLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登入'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person_pin, size: 80),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    focusNode: _focusNodeUser,
                    controller: _userController,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_focusNodePW);
                    },
                    decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "不要太长的字符",
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 30,
                  ),
                  child: TextField(
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    focusNode: _focusNodePW,
                    controller: _pwController,
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "不要太简单的字符",
                        prefixIcon: Icon(Icons.lock)),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    onPressed: () {
                      requestRegister(context);
                    },
                    textColor: Colors.lightBlueAccent,
                    child: Text('点击注册'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: RaisedButton(
                    child: Text("确定"),
                    onPressed: () {
                      requestLogin();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 用于控制切换焦点
  FocusNode _focusNodeUser = new FocusNode();
  FocusNode _focusNodePW = new FocusNode();

  // 用于获取输入文本
  TextEditingController _userController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  /// 请求登陆
  void requestLogin() {
    var username = _userController.text;
    var password = _pwController.text;
    HttpDio().dio.post(Url.userLogin,
        data: {'username': username, 'password': password}).then((value) {
      return Future.value(RegisteredEntity().fromJson(value.data));
    }).then((value) {
      if (value.errorCode == 0) {
        showToast('登陆成功',
            context: context, position: StyledToastPosition.center);
        Navigator.pop(context, "哈哈哈登陆成功了");

        AppStatus.isAlreadyLogin = true;

//        List<Cookie> cookies = [];
//        HttpDio()
//            .cookieJar.saveFromResponse(Uri.parse(Url.baseUrl + Url.userLogin), cookies);
        print('cookie：' +
            HttpDio()
                .cookieJar
                .loadForRequest(Uri.parse(Url.baseUrl + Url.userLogin))
                .toString());
      }
    }).catchError((error) {
      print('错误：$error');
    });
  }

  /// 请求注册
  void requestRegister(BuildContext context) {
    var username = _userController.text;
    var password = _pwController.text;
    HttpDio().dio.post(Url.userRegister, data: {
      'username': username,
      'password': password,
      'repassword': password,
    }).then((value) {
      return Future.value(RegisteredEntity().fromJson(value.data));
    }).then((value) {
      if (value.errorCode == 0) {
        showToast('注册成功',
            context: context, position: StyledToastPosition.center);
      }
    }).catchError((error) {
      print('错误：$error');
    });
  }
}
