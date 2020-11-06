class Url {
  static const baseUrl = 'https://www.wanandroid.com';

  /// 首页文章列表  /article/list/0/json，页面拼接在链接中的
  static articleList(index) => '/article/list/$index/json';

  /// 收藏站内文章
  static collect(id) => '/lg/collect/$id/json';

  /// 登陆接口
  static const userLogin = '/user/login';

  /// 注册接口
  static const userRegister = '/user/register';

  /// 搜索接口
  static search(index) => '/article/query/$index/json';
}
