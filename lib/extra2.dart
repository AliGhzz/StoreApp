import 'package:dio/dio.dart';
import 'package:f1/Models/pageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<PageViewModel>> pageViewFuture;
  PageController pageController = PageController(keepPage: true,initialPage: 1,viewportFraction: 0.85 );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageViewFuture = sendRequestPageView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("DigiKala"),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
          ],
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber),
                    height: 170, 
                    child: FutureBuilder<List<PageViewModel>>(
                        future: pageViewFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<PageViewModel>? pageViewFuture = snapshot.data;
                            return Container(
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  PageView.builder(
                                      controller: pageController,
                                      allowImplicitScrolling: true,
                                      itemCount: pageViewFuture!.length,
                                      itemBuilder: (context, index) {
                                        return showPageView(pageViewFuture[index]);
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: SmoothPageIndicator(
                                      controller: pageController,
                                      count: pageViewFuture!.length,
                                      effect: ExpandingDotsEffect(
                                        dotHeight: 10,
                                        dotWidth: 10,
                                        dotColor: Colors.white,
                                        spacing: 3,
                                        activeDotColor: Colors.red
                                      ),
                                      onDotClicked: (index) {
                                        pageController.animateToPage(index,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOutCubicEmphasized);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                  CollectionSlideTransition(
                                    children: <Widget>[
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.yellow[300],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.yellow[600],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.orange[400],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.orange[600],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.orange[800],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.red[400],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.red[500],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.red[600],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.red[700],
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.red[800],
                                      ),
                                    ],
                                  ),
                                ]));
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  //methods

  Future<List<PageViewModel>> sendRequestPageView() async {
    List<PageViewModel> models = [];
    /*
    dynamic response =await Dio().get("given api isn's working,so we use 4 urls");
    for (var item in Response.data) {
      models.add(PageViewModel(item[0], item[1]));
    }
    */

    var response = [
      "https://dkstatics-public.digikala.com/digikala-adservice-banners/aa50ca4d614c91742f231cab21772eee91515b7e_1690058927.jpg?x-oss-process=image/quality,q_95/format,webp",
      "https://dkstatics-public.digikala.com/digikala-adservice-banners/b279740ab8e28cb82b5fbda02d728206b321d821_1692030401.jpg?x-oss-process=image/quality,q_95/format,webp",
      "https://dkstatics-public.digikala.com/digikala-adservice-banners/5502b48d35bdc2c46b8ee39878fa1b63f5b0b11e_1692721069.jpg?x-oss-process=image/quality,q_95/format,webp",
      "https://dkstatics-public.digikala.com/digikala-adservice-banners/6065cab36954954ec0e83dc9d76ec6c6db7ef66a_1692781545.jpg?x-oss-process=image/quality,q_95/format,webp",
    ];
    for (int i = 0; i < 4; i++) {
      models.add(PageViewModel(i + 1, response[i]));
    }
    return models;
  }


  Padding showPageView(PageViewModel photo){
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 5, top: 5, left: 5, right: 5),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: ClipRRect(
          child: Image.network(
            photo.image!,
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(15),
        )
      ),
    );
  }
}
