import 'package:dio/dio.dart';
import 'package:f1/Models/eventModel.dart';
import 'package:f1/Models/pageViewModel.dart';
import 'package:f1/Models/specialOffers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'extra2.dart';
import 'singleProduct.dart';
import 'dart:math';






void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<PageViewModel>> pageViewFuture;
  late Future<List<SpecialOffers>> specialOfferFuture;
  late Future<List<EventsModel>> eventFuture;
  PageController pageController =
      PageController(keepPage: true, initialPage: 5001);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageViewFuture = sendRequestPageView();
    specialOfferFuture = sendRequestSpecialOffers();
    eventFuture = sendRequestEvents();
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
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.red,
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5 - 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border_outlined,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5 - 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.rectangle_grid_2x2 ,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.home_outlined, size: 35),
          backgroundColor: Colors.red,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        drawer: Drawer(),
        appBar: AppBar(
          // leading: Icon(CupertinoIcons.person),
          toolbarHeight: 55,
          backgroundColor: Colors.red,
          title: Text("DigiKala"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
          ],
          elevation: 5,
        ),
        body: SingleChildScrollView(
          child: Container(
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
                                            duration:
                                                Duration(milliseconds: 300),
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
                              List<SpecialOffers>? specialOfferFutureSnap =
                                  snapshot.data;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  physics: BouncingScrollPhysics(
                                      decelerationRate:
                                          ScrollDecelerationRate.fast),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: specialOfferFutureSnap!.length + 1,
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
                                                onPressed: () {
                                                  Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return AllProducts(specialOfferFuture);
                                                }));
                                                },
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
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } 
                                    else if (position <= 6 && position >= 1) {
                                      return showSpecialOffer(
                                          specialOfferFutureSnap[position - 1]);
                                    } 
                                    else if (position == 7) {
                                      return Center(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return AllProducts(specialOfferFuture);
                                              }));
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.navigate_before,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 3),
                                                  child: Text(
                                                    "مشاهده همه",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontFamily: 'iranyekan',
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
                                          ));
                                    }
                                  });
                            } else {
                              return Center(
                                child: JumpingDotsProgressIndicator(
                                  color: Colors.white,
                                  numberOfDots: 3,
                                  dotSpacing: 3,
                                  fontSize: 5,
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      child: FutureBuilder<List<EventsModel>>(
                        future: eventFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<EventsModel>? eventFuture = snapshot.data;
                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                              "assets/images/" +
                                                  eventFuture![0].image!,
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                              "assets/images/" +
                                                  eventFuture![1].image!,
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                                "assets/images/" +
                                                    eventFuture![2].image!,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                                "assets/images/" +
                                                    eventFuture![3].image!,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: JumpingDotsProgressIndicator(
                                color: Colors.white,
                                numberOfDots: 3,
                                dotSpacing: 3,
                                fontSize: 5,
                              ),
                            );
                          }
                        },
                      )),
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
          fit: BoxFit.fill , 
        ),
        borderRadius: BorderRadius.circular(15),
        // child: Image.network(
        //   photo.image!,
        //   fit: BoxFit.fill,
        // ),
      )),
    );
  }

  Future<List<EventsModel>> sendRequestEvents() async {
    List<EventsModel> models = [];
    /*
    dynamic response =await Dio().get("given api isn's working");
    for (var item in Response.data) {
      models.add(SpecialOffers(item));
    }
    */
    var response = ["event1.webp", "event2.webp", "event3.webp", "event4.webp"];
    for (int i = 0; i < response.length; i++) {
      models.add(EventsModel(response[i]));
    }
    return models;
  }
  InkWell showSpecialOffer(SpecialOffers specialoffer) {
    return InkWell(
      onTap: () {
        Navigator.push(context , MaterialPageRoute(builder: (context) {
          return SingleProduct(specialoffer);
        }));
      },
      child: Container(
        height: 220,
        width: 140,
        child: Card(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 2.5, right: 2.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "شگفت انگیز اختصاصی اپ",
                    style: TextStyle(
                        fontFamily: 'iranyekan',
                        fontSize: 9,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/" + specialoffer.image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35 ,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        specialoffer.Product_name!,
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 9,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1, right: 2),
                        child: Image.asset(
                          "assets/images/toman.png",
                          width: 13,
                          height: 13,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            specialoffer.off_price!
                                .toString()
                                .toPersianDigit()
                                .seRagham(),
                            style: TextStyle(
                                fontFamily: 'iranyekan',
                                fontSize: 9,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            specialoffer.price!
                                .toString()
                                .toPersianDigit()
                                .seRagham(),
                            style: TextStyle(
                                fontFamily: 'iranyekan',
                                fontSize: 9,
                                color: Colors.black38,
                                fontWeight: FontWeight.w100,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: 28,
                        height: 15,
                        child: Align(
                          child: Text(
                            specialoffer.off_percent!
                                    .toString()
                                    .toPersianDigit() +
                                "%",
                            style: TextStyle(
                              fontFamily: 'iranyekan',
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10)
                    ],
                  )
                ],
              ),
            )),
      ),
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
      [1, "گوشی موبایل شیائومی مدل Redmi Note 12 4G دو سیم کارت ظرفیت 128 گیگابایت و رم 8 گیگابایت - گلوبال", 5000000, 4000000, 20, "box2.webp",4.7,"موبایل و تلفن همراه"],
      [2, "ساعت هوشمند سامسونگ مدل Galaxy Watch5 Ultra", 1200000, 1000000, 18, "box3.webp",3.5,"ساعت هوشمند"],
      [3, "ایرپاد", 500000, 450000, 10, "box4.webp",2.9,"هدفون و هنذزفری"],
      [4, "گوشی موتورولا", 8000000, 6000000, 25, "box5.webp",4.2,"موبایل و تلفن همراه"],
      [5, "کتونی ورزشی", 2000000, 1400000, 30, "box6.webp",4.5,"پوشاک"],
      [6, "هدفون", 437000, 355900, 19, "box7.webp",4,"هدفون و هندزفری"],
      [7, "لپ تاپ 13.3 اینچی اپل مدل MacBook Air MGN63 2020 LLA", 42330000, 44100000, 4, "box8.webp",3.6,"کامپیوتر و لپ تاپ"],
      [8, "دوربین", 10769000, 12100000, 11, "box9.webp",3.9,"ابزار و وسایل"],
    ];
    // DateTime.now().toPersianDateStr(strDay: true, strMonth: true,monthString: );
    var value = intl.NumberFormat("#,###.##", "en_US");
    for (int i = 0; i < response.length; i++) {
      models.add(SpecialOffers(
          response[i][0] as num,
          response[i][1] as String,
          response[i][2] as num,
          response[i][3] as num,
          response[i][4] as num,
          response[i][5] as String,
          response[i][6] as num,
          response[i][7] as String,
          ));
    }
    return models;
  }
}


