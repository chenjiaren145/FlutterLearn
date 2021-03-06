// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:my_flutter/bean/home_article_entity.dart';
import 'package:my_flutter/generated/json/home_article_entity_helper.dart';
import 'package:my_flutter/bean/registered_entity.dart';
import 'package:my_flutter/generated/json/registered_entity_helper.dart';

class JsonConvert<T> {
  T fromJson(Map<String, dynamic> json) {
    return _getFromJson<T>(runtimeType, this, json);
  }

  Map<String, dynamic> toJson() {
    return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
      case HomeArticleEntity:
        return homeArticleEntityFromJson(data as HomeArticleEntity, json) as T;
      case HomeArticleData:
        return homeArticleDataFromJson(data as HomeArticleData, json) as T;
      case HomeArticleDataData:
        return homeArticleDataDataFromJson(data as HomeArticleDataData, json)
            as T;
      case RegisteredEntity:
        return registeredEntityFromJson(data as RegisteredEntity, json) as T;
      case RegisteredData:
        return registeredDataFromJson(data as RegisteredData, json) as T;
    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
    switch (type) {
      case HomeArticleEntity:
        return homeArticleEntityToJson(data as HomeArticleEntity);
      case HomeArticleData:
        return homeArticleDataToJson(data as HomeArticleData);
      case HomeArticleDataData:
        return homeArticleDataDataToJson(data as HomeArticleDataData);
      case RegisteredEntity:
        return registeredEntityToJson(data as RegisteredEntity);
      case RegisteredData:
        return registeredDataToJson(data as RegisteredData);
    }
    return data as T;
  }

  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {
      case 'HomeArticleEntity':
        return HomeArticleEntity().fromJson(json);
      case 'HomeArticleData':
        return HomeArticleData().fromJson(json);
      case 'HomeArticleDataData':
        return HomeArticleDataData().fromJson(json);
      case 'RegisteredEntity':
        return RegisteredEntity().fromJson(json);
      case 'RegisteredData':
        return RegisteredData().fromJson(json);
    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {
      case 'HomeArticleEntity':
        return <HomeArticleEntity>[];
      case 'HomeArticleData':
        return <HomeArticleData>[];
      case 'HomeArticleDataData':
        return <HomeArticleDataData>[];
      case 'RegisteredEntity':
        return <RegisteredEntity>[];
      case 'RegisteredData':
        return <RegisteredData>[];
    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}
