import 'package:MyFlutter/config/app_status.dart';
import 'package:MyFlutter/page/padge_config.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserStatus();
  }
}

class UserStatus extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: double.infinity, minWidth: double.infinity),
        child: Row(
          children: [
            FlatButton(
              onPressed: () async {
                var result =
                    await Navigator.pushNamed(context, PageConfig.userLogin);
                // 暂时直接这样更新下
                setState(() {});
                print('user_login.dart的返回值：$result');
              },
              child: Center(
                child: Text(AppStatus.isAlreadyLogin ? '登入状态' : '未登入'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
