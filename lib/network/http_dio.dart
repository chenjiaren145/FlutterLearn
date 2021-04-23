import 'package:my_flutter/network/url.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

/// 封装dio库的网络请求
class HttpDio {
  Dio dio;
  CookieJar cookieJar;

  // 静态私有成员，没有初始化
  static HttpDio _instance;

  // 单例公开访问点
  factory HttpDio([BaseOptions options]) => _sharedInstance(options);

  // 私有构造函数
  HttpDio._([BaseOptions options]) {
    print('http_dio 构造方法执行');
    dio = Dio();
    if (options == null) {
      options = BaseOptions(
          baseUrl: Url.baseUrl,
          connectTimeout: 5000,
          // 链接超时
          receiveTimeout: 6000,
          // 接受数据超时
          contentType: Headers.formUrlEncodedContentType);
    }
    dio.options = options;
    // cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));

//    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//      // config the http client
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return "PROXY 10.0.24.240:8888";
//      };
//      // you can also create a new HttpClient to dio
//      // return new HttpClient();
//    };
  }

  // 静态、同步、私有访问点
  static HttpDio _sharedInstance(BaseOptions options) {
    if (_instance == null) {
      _instance = HttpDio._(options);
    }
    return _instance;
  }
}
