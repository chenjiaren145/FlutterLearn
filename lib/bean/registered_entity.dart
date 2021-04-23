import "package:my_flutter/generated/json/base/json_convert_content.dart";

class RegisteredEntity with JsonConvert<RegisteredEntity> {
  RegisteredData data;
  int errorCode;
  String errorMsg;
}

class RegisteredData with JsonConvert<RegisteredData> {
  bool admin;
  List<dynamic> chapterTops;
  int coinCount;
  List<dynamic> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;
}
