import 'package:MyFlutter/network/url.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
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
        connectTimeout: 5000, // 链接超时
        receiveTimeout: 6000, // 接受数据超时
        contentType: Headers.formUrlEncodedContentType,
      );
    }
    dio.options = options;
    cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // 在请求被发送之前做一些事情
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) async {
      // 在返回响应数据之前做一些预处理
      return response; // continue
    }, onError: (DioError e) async {
      // 当请求失败时做一些预处理
      return e; //continue
    }));

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
