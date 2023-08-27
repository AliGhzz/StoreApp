import 'package:dio/dio.dart';
import 'package:f1/Models/pageViewModel.dart';
import 'package:f1/Models/specialOffers.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  late Future<List<SpecialOffers>> specialOfferFuture;
  PageController pageController =
      PageController(keepPage: true, initialPage: 5001, viewportFraction: 0.85);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageViewFuture = sendRequestPageView();
    specialOfferFuture = sendRequestSpecialOffers();
    startInfiniteLoop();
  }

  void startInfiniteLoop() {
    Future.delayed(Duration(seconds: 5), () {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      startInfiniteLoop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          toolbarHeight: 55,
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.white),
                  height: 150,
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
                                    // itemCount: pageViewFuture!.length,
                                    // reverse: true,
                                    // scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      // final index = _index;
                                      // print(pageController.page);
                                      return showPageView(
                                          pageViewFuture![index % 4]);
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
                                      activeDotColor: Colors.red,
                                    ),
                                    onDotClicked: (index) {
                                      pageController.animateToPage(index,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut);
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
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Container(
                    color: Colors.red,
                    height: 250,
                    width: double.infinity,
                    child: FutureBuilder<List<SpecialOffers>>(
                        future: specialOfferFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<SpecialOffers>? specialOfferFuture =
                                snapshot.data;
                            return ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: specialOfferFuture!.length + 1,
                                itemBuilder: (context, position) {
                                  if (position == 0) {
                                    return Container(
                                      width: 150,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                            child: SvgPicture.asset(
                                                "assets/images/Amazings.svg",
                                                height: 90),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Image.asset(
                                              "assets/images/box1.webp",
                                              width: 110,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.navigate_before,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 3),
                                                    child: Text(
                                                      "مشاهده همه",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontFamily:
                                                              'iranyekan',
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return showSpecialOffer(
                                        specialOfferFuture[position-1]);
                                  }
                                });
                          } else {
                            return JumpingDotsProgressIndicator(
                              color: Colors.white,
                              numberOfDots: 3,
                              dotSpacing: 3,
                              fontSize: 5,
                            );
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
    dynamic response =await Dio().get("given api isn's working");
    for (var item in Response.data) {
      models.add(PageViewModel(item[0], item[1]));
    }
    */
    // var response = [
    //   "https://dkstatics-public.digikala.com/digikala-adservice-banners/aa50ca4d614c91742f231cab21772eee91515b7e_1690058927.jpg?x-oss-process=image/quality,q_95/format,webp",
    //   "https://dkstatics-public.digikala.com/digikala-adservice-banners/b279740ab8e28cb82b5fbda02d728206b321d821_1692030401.jpg?x-oss-process=image/quality,q_95/format,webp",
    //   "https://dkstatics-public.digikala.com/digikala-adservice-banners/5502b48d35bdc2c46b8ee39878fa1b63f5b0b11e_1692721069.jpg?x-oss-process=image/quality,q_95/format,webp",
    //   "https://dkstatics-public.digikala.com/digikala-adservice-banners/6065cab36954954ec0e83dc9d76ec6c6db7ef66a_1692781545.jpg?x-oss-process=image/quality,q_95/format,webp",
    // ];
    var response = ["dg1.webp", "dg2.webp", "dg3.webp", "dg4.webp"];
    for (int i = 0; i < response.length; i++) {
      models.add(PageViewModel(i + 1, response[i]));
    }
    return models;
  }

  Padding showPageView(PageViewModel photo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
      child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: ClipRRect(
        child: Image.asset(
          "assets/images/" + photo.image!,
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(15),
        // child: Image.network(
        //   photo.image!,
        //   fit: BoxFit.fill,
        // ),
      )),
    );
  }

  Future<List<SpecialOffers>> sendRequestSpecialOffers() async {
    List<SpecialOffers> models = [];
    /*
    dynamic response =await Dio().get("given api isn's working");
    for (var item in Response.data) {
      models.add(SpecialOffers(item[0], item[1],item[2], item[3],item[4], item[5],));
    }
    */
    var response = [
      [1, "گوشی شیائومی", 5000000, 4000000, 20, "box2.webp"],
      [2, "ساعت", 1200000, 1000000, 18, "box3.webp"],
      [3, "ایرپاد", 500000, 450000, 10, "box4.webp"],
      [4, "گوشی موتورولا", 8000000, 6000000, 25, "box5.webp"],
      [5, "کتونی ورزشی", 2000000, 1400000, 30, "box6.webp"],
    ];
    for (int i = 0; i < response.length; i++) {
      // num price = response[i][2]as num ;
      // num off_price=response[i][3]as num ;
      models.add(SpecialOffers(
          response[i][0] as num?,
          response[i][1] as String?,
          response[i][2] as num?,
          response[i][3] as num?,
          response[i][4] as num?,
          response[i][5] as String?));
    }
    return models;
  }

  Container showSpecialOffer(SpecialOffers specialoffer) {
    return Container(
      height: 220,
      width: 140,
      child: Card(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 2.5, right: 2.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Text("شگفت انگیز اختصاصی اپ",
                  style: TextStyle(
                  fontFamily: 'iranyekan',
                  fontSize: 9 ,
                  color: Colors.red,
                  fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 10,),
                Image.asset("assets/images/"+specialoffer.image!,width: 100,height: 100,fit: BoxFit.fill,),
                SizedBox(height: 10,),
                Text(specialoffer.Product_name!,
                style: TextStyle(
                  fontFamily: 'iranyekan',
                  fontSize: 9 ,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height:15 ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(specialoffer.off_price!.toString()+"T",
                        style: TextStyle(
                          fontFamily: 'iranyekan',
                          fontSize: 9 ,
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                          ),
                        ),
                        Text(specialoffer.price!.toString()+"T",
                        style: TextStyle(
                          fontFamily: 'iranyekan',
                          fontSize: 9 ,
                          color: Colors.black38,
                          fontWeight: FontWeight.w100,
                          decoration: TextDecoration.lineThrough
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:BorderRadius.circular(15), 
                      ),
                      width:28,
                      height:15,
                      child: Align(
                        child: Text(specialoffer.off_percent!.toString()+"%",
                          style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 9 ,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width:10)
                  ],
                )
              ],
            ),
          )
        ),
    );
  }
}
