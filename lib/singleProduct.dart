import 'package:f1/Models/specialOffers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math';

class SingleProduct extends StatelessWidget {
  SpecialOffers specialoffer;

  SingleProduct(this.specialoffer);
  final controller = PageController(viewportFraction: 1, keepPage: true);
  int colorCount = Random().nextInt(9) + 1;
  var allcolors = [
    [Colors.red, false, "قرمز"],
    [Colors.blue, false, "آبی"],
    [Colors.green, false, "سبز"],
    [Colors.brown, false, "قهوه ای"],
    [Colors.grey, false, "طوسی"],
    [Colors.yellow, false, "زرد"],
    [Colors.pink, false, "صورتی"],
    [Colors.orange, false, "نارنجی"],
    [Colors.purple, false, "بنفش"]
  ];
  int satisfacation_percentage = Random().nextInt(80) + 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          height: 60,
          // color: Colors.amber,
          // color: Colors.white ,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        Text(
                          specialoffer.price
                              .toString()
                              .toPersianDigit()
                              .seRagham(),
                          style: TextStyle(
                              fontFamily: 'iranyekan',
                              fontSize: 11,
                              color: Colors.black54,
                              fontWeight: FontWeight.w100,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 35,
                          height: 20,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              specialoffer.off_percent!
                                      .toString()
                                      .toPersianDigit() +
                                  "%",
                              style: TextStyle(
                                fontFamily: 'iranyekan',
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/toman.png",
                            width: 14,
                            height: 14,
                            fit: BoxFit.contain,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          specialoffer.off_price!
                              .toString()
                              .toPersianDigit()
                              .seRagham(),
                          style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 140,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            size: 20,
                          ),
                          Text(" افزودن به سبد خرید",
                              style: TextStyle(
                                  fontFamily: 'iranyekan',
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: Colors.red,
          title: Text("DigiKala"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.bookmark_add_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 20, bottom: 5),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text("پیشنهاد شگفت انگیز",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 11,
                            color: Colors.red,
                            fontWeight: FontWeight.w100)),
                  ),
                ),
                Divider(
                  height: 3,
                  color: Colors.red,
                  thickness: 2,
                  endIndent: 15,
                  indent: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Container(
                    height: 235,
                    width: double.infinity,
                    // color: Colors.amber,
                    child: Stack(children: [
                      Align(
                        child: Image.asset(
                          //implement with page view builder for showing images later
                          "assets/images/" + specialoffer.image!,
                          width: 240,
                          height: 225,
                          fit: BoxFit.fill,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 190),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmoothPageIndicator(
                                controller: controller,
                                count: 50,
                                textDirection: TextDirection.rtl,
                                effect: ScrollingDotsEffect(
                                  dotHeight: 6,
                                  dotWidth: 6,
                                  activeDotColor: Colors.black,
                                  spacing: 5,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.play_rectangle,
                                    size: 30,
                                    color: Colors.black54,
                                  ))
                            ]),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(specialoffer.category!,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 11,
                            color: Colors.blue,
                            fontWeight: FontWeight.w100)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(specialoffer.Product_name!,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                              (Random().nextInt(1000) + 250)
                                      .toString()
                                      .toPersianDigit() +
                                  " پرسش و پاسخ   ",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'iranyekan',
                                fontSize: 11,
                                color: Colors.blue,
                                fontWeight: FontWeight.w100,
                              )),
                        ),
                        Icon(
                          Icons.circle,
                          size: 5,
                          color: Colors.black12,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                              (Random().nextInt(1000) + 250)
                                      .toString()
                                      .toPersianDigit() +
                                  " دیدگاه کاربران",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'iranyekan',
                                fontSize: 11,
                                color: Colors.blue,
                                fontWeight: FontWeight.w100,
                              )),
                        ),
                        Icon(
                          Icons.circle,
                          size: 5,
                          color: Colors.black12,
                        ),
                        Text(
                            "    (" +
                                (Random().nextInt(1000) + 50)
                                    .toString()
                                    .toPersianDigit() +
                                ") ",
                            style: TextStyle(
                              fontFamily: 'iranyekan',
                              fontSize: 10,
                              color: Colors.black26,
                              fontWeight: FontWeight.w900,
                            )),
                        Text(
                          specialoffer.star.toString().toPersianDigit(),
                          style: TextStyle(
                              fontFamily: 'iranyekan',
                              fontSize: 10,
                              color: Colors.black87,
                              fontWeight: FontWeight.w100),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                      ],
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        " %" +
                            (satisfacation_percentage)
                                .toString()
                                .toPersianDigit() +
                            " (" +
                            (Random().nextInt(200) + 50)
                                .toString()
                                .toPersianDigit() +
                            "نفر) از خریداران این کالا را پیشنهاد کرده اند",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 11,
                            color: Colors.black54,
                            fontWeight: FontWeight.w100),
                      ),
                      showIconForSatisfacation(satisfacation_percentage),
                    ],
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                  endIndent: 15,
                  indent: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 5, top: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("رنگ : ",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 42,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colorCount,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return showColors();
                      }),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 10,
                  thickness: 7,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("فروشنده",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontFamily: 'iranyekan',
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Container(
                            height: 45,
                            width: double.infinity,
                            // color: Colors.amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.navigate_before,color: Colors.black38 ,),
                                Spacer(), 
                                Column(
                                  crossAxisAlignment:CrossAxisAlignment.end ,
                                  children: [
                                    
                                    Text("دیجی کالا",
                                        style: TextStyle(
                                            fontFamily: 'iranyekan',
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w200,letterSpacing:0,wordSpacing:0)),
                                    Row(
                                      children: [
                                        selectColor(satisfacation_percentage),
                                        Text("عملکرد",
                                        style: TextStyle(
                                            fontFamily: 'iranyekan',
                                            fontSize: 10,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w200)),
                                      ],
                                    ), 
                                  ],
                                ),
                                SizedBox(width: 5,), 
                                Icon(Icons.store_mall_directory_outlined,size: 24,color: Colors.red,),
                              ],
                            )
                          ),
                      ),
                      Divider(
                        endIndent: 29,
                        indent: 7,
                        height: 4,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(" گارانتی "+"18".toPersianDigit()+" ماهه دیجی کالا"
                                        ,style: TextStyle( 
                                            fontFamily: 'iranyekan',
                                            fontSize: 12, 
                                            color: Colors.black,
                                            fontWeight: FontWeight.w200,
                                            letterSpacing:0,wordSpacing:0
                                            ),
                                          ),
                            SizedBox(width: 5,), 
                            Icon(CupertinoIcons.checkmark_shield,color: Colors.blue ,)
                          ],
                        ),
                      ),
                      Divider(
                        endIndent: 29,
                        indent: 7,
                        height: 4,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("موجود در انبار دیجی کالا"
                                        ,style: TextStyle( 
                                            fontFamily: 'iranyekan',
                                            fontSize: 12, 
                                            color: Colors.black,
                                            fontWeight: FontWeight.w200,
                                            letterSpacing:0,wordSpacing:0
                                            ),
                                          ), 
                            SizedBox(width: 5,), 
                            Icon(Icons.warehouse_outlined ,color: Colors.green,)
                          ],
                        ),
                      ),
                      Divider(
                        endIndent: 29,
                        indent: 7,
                        height: 4,
                      ),
                    ],
                  ),
                  )
              ],
            ),
          ),
        ));
  }

  Text selectColor(satisfacation_percentage) {
    if (satisfacation_percentage >= 85) {
      return Text(        
            "عالی",
            style: TextStyle(color: Colors.green,fontFamily: 'iranyekan',
                                      fontSize: 10,),
      );
    } else if (satisfacation_percentage >= 65) {
      return Text(
            "خوب",
            style: TextStyle(color: Colors.greenAccent,fontFamily: 'iranyekan',
                                      fontSize: 10,),
      );
    } else if (satisfacation_percentage >= 45) {
      return Text(
            "معمولی",
            style: TextStyle(color: Colors.yellow,fontFamily: 'iranyekan',
                                      fontSize: 10,),
      );
    } else {
      return Text(
            "ضعیف",
            style: TextStyle(color: Colors.orange,fontFamily: 'iranyekan',
                                      fontSize: 10,),
      );
    }
  }

  Icon showIconForSatisfacation(satisfacation_percentage) {
    if (satisfacation_percentage >= 70) {
      return Icon(
        Icons.thumb_up_alt_outlined,
        color: Colors.green,
        size: 20,
      );
    } else if (satisfacation_percentage >= 50) {
      return Icon(
        Icons.thumb_up_alt_outlined,
        color: Colors.yellow,
        size: 20,
      );
    } else if (satisfacation_percentage >= 30) {
      return Icon(
        Icons.thumb_up_alt_outlined,
        color: Colors.orange,
        size: 20,
      );
    } else {
      return Icon(
        Icons.thumb_up_alt_outlined,
        color: Colors.red,
        size: 20,
      );
    }
  }

  InkWell showColors() {
    bool send = false;
    while (send != true) {
      int x = Random().nextInt(9);
      if (allcolors[x][1] == false) {
        allcolors[x][1] = true;
        send = true;
        return InkWell(
          onTap: () {},
          child: Card(
            elevation: 2,
            color: Colors.white,
            margin: EdgeInsets.all(5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    allcolors[x][2].toString(),
                    style: TextStyle(
                        fontFamily: 'iranyekan',
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                CircleAvatar(
                  backgroundColor: allcolors[x][0] as Color,
                  maxRadius: 10,
                  // backgroundColor: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        );
      }
    }
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 10,
          height: 10,
          color: Colors.red,
        ),
      ),
    );
  }
}
