import 'package:MyFlutter/bean/home_article_entity.dart';
import 'package:MyFlutter/network/http_dio.dart';
import 'package:MyFlutter/network/url.dart';
import 'package:MyFlutter/page/padge_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  /// 首页文章列表
  List<HomeArticleDataData> articles = <HomeArticleDataData>[];
  Set<HomeArticleDataData> _saved = Set<HomeArticleDataData>();

  /// 当前页数，每页固定20个
  int curPage = 0;

  /// 总的页数
  int pageCount = 0;

  /// 滑动控制器
  ScrollController scrollController = new ScrollController();

  /// 是否显示正在加载更多
  var isLoading = false;

  /// 是否显示回到顶部的fab
  var isTop = false;

  @override
  void initState() {
    super.initState();

    requestData(0);

    scrollController.addListener(() {
      // 触发分页请求
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          curPage <= pageCount) {
        requestData(curPage);
      }

      // 触发fab显示或隐藏
      if (scrollController.position.pixels > 400 && !isTop) {
        setState(() {
          isTop = true;
        });
      } else if (scrollController.position.pixels <= 400 && isTop) {
        setState(() {
          isTop = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      floatingActionButton: getFloatingActionButton(context),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: articles.length > 0
            ? ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: articles.length + 1, // 多加一个显示更多or透明
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  if (index == articles.length) {
                    return buildProgressIndicator();
                  } else {
                    return buildItem(index, context);
                  }
                })
            : Center(
                child: const Text('No items'),
              ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget buildItem(int index, BuildContext context) {
    var itemData = articles[index];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageConfig.homeDoc,
            arguments: {'title': itemData.title, 'link': itemData.link});
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData.title,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemData.chapterName,
                    style: TextStyle(fontSize: 14),
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: itemData.collect
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    onPressed: () {
                      requestCollect(index, itemData.id);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '平台：${itemData.shareUser} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 13),
                    child: Text(
                      itemData.niceShareDate,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 加载中的圆形进度条
  Widget buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: new SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }

  /// 获取浮动按钮，仅在首页显示
  getFloatingActionButton(BuildContext context) {
    if (isTop) {
      return FloatingActionButton(
        onPressed: () {
          this.scrollController.animateTo(0,
              duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
        },
        tooltip: 'Increment',
        child: Icon(Icons.arrow_upward),
      );
    } else {
      return null;
    }
  }

  /// 请求收藏接口（站内文章的）
  requestCollect(int index, int id) {
    HttpDio().dio.post(Url.collect(id)).then((value) => print(value));
  }

  /// 请求文章列表数据
  Future<void> requestData(int index) {
    if (index != 0 && isLoading == false) {
      setState(() {
        isLoading = true;
      });
    }
    return HttpDio().dio.request(Url.articleList(index)).then((value) {
      return Future.value(HomeArticleEntity().fromJson(value.data));
    }).then((result) {
      print('首页文章数据返回');
      // result.data.curPage 是从1开始的，请求链接中的页码是从0开始的。
      this.curPage = result.data.curPage;
      this.pageCount = result.data.pageCount;
      setState(() {
        articles += result.data.datas;
        isLoading = false;
      });
    }).catchError((error) {
      print('失败了: ${error.toString()}');
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> onRefresh() async {
    await requestData(0);
  }
}
