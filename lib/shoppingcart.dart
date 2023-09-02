import 'dart:async';
import 'package:f1/maps.dart';
import 'package:f1/singleProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'Models/specialOffers.dart';
import 'main.dart';

// import 'singleProduct.dart';
StreamController<List>? baskets;

class sCart extends StatefulWidget {
  @override
  State<sCart> createState() => _sCartState();
}

class _sCartState extends State<sCart> {
  @override
  void initState() {
    super.initState();
    baskets = StreamController<List>();
  }

  @override
  Widget build(BuildContext context) {
    baskets!.add(basket);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.red,
        title: Text("DigiKala"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GoogleMaps();
                }));
              },
              icon: Icon(Icons.location_on_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            checkCartIsNotEmpty(basket),
            Container(
              child: StreamBuilder<List>(
                  stream: baskets!.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List? lst = snapshot.data;
                      return GridView.builder(
                        itemCount: lst!.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 600,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          mainAxisExtent: 235,
                          childAspectRatio: 2,
                        ),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return showSpecialOfferGridView(
                              lst[index][0], lst[index][1], index);
                        },
                      );
                    } else {
                      return Container(
                        height: 100,
                        width: 100,
                        color: Colors.black,
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Container checkCartIsNotEmpty(basket) {
    if (basket.length == 0) {
      return Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Row(
                  children: [
                    Text(
                      "کالا ",
                      style: TextStyle(
                          fontFamily: 'iranyekan',
                          fontSize: 11,
                          color: Colors.black45,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      (basket.length).toString().toPersianDigit().seRagham(),
                      style: TextStyle(
                          fontFamily: 'iranyekan',
                          fontSize: 11,
                          color: Colors.black45,
                          fontWeight: FontWeight.w100),
                    ),
                    Spacer(),
                    Text("لیست کالاهای سبد خرید ",
                        style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: Text(
                  "سبد خرید شما خالی است",
                  style: TextStyle(
                      fontFamily: 'iranyekan',
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      num x = 0;
      for (int i = 0; i < basket.length; i++) {
        x += basket[i][1];
      }
      return Container(
        width: double.infinity,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Row(
            children: [
              Text(
                "کالا ",
                style: TextStyle(
                    fontFamily: 'iranyekan',
                    fontSize: 11,
                    color: Colors.black45,
                    fontWeight: FontWeight.w100),
              ),
              Text(
                (x).toString().toPersianDigit().seRagham(),
                style: TextStyle(
                    fontFamily: 'iranyekan',
                    fontSize: 11,
                    color: Colors.black45,
                    fontWeight: FontWeight.w100),
              ),
              Spacer(),
              Text("لیست کالاهای سبد خرید ",
                  style: TextStyle(
                      fontFamily: 'iranyekan',
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w500))
            ],
          ),
        ),
      );
    }
  }

  Column showSpecialOfferGridView(
      SpecialOffers specialoffer, int count, int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              specialoffer.Product_name!,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: 'iranyekan',
                                  fontSize: 11,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "گارانتی اصالت و سلامت فیزیکی کالا",
                              style: TextStyle(
                                  fontFamily: 'iranyekan',
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  letterSpacing: 0,
                                  wordSpacing: 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              CupertinoIcons.checkmark_shield,
                              color: Colors.blue,
                              size: 15,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("دیجی کالا",
                                    style: TextStyle(
                                        fontFamily: 'iranyekan',
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                        letterSpacing: 0,
                                        wordSpacing: 0)),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.store_mall_directory_outlined,
                              size: 15,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "موجود در انبار دیجی کالا",
                              style: TextStyle(
                                  fontFamily: 'iranyekan',
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  letterSpacing: 0,
                                  wordSpacing: 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.warehouse_outlined,
                              color: Colors.green,
                              size: 15,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "ارسال دیجی کالا",
                              style: TextStyle(
                                  fontFamily: 'iranyekan',
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  letterSpacing: 0,
                                  wordSpacing: 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.delivery_dining_outlined,
                              color: Colors.yellow,
                              size: 15,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "ارسال فوری",
                              style: TextStyle(
                                  fontFamily: 'iranyekan',
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  letterSpacing: 0,
                                  wordSpacing: 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.rocket_outlined,
                              color: Colors.orange,
                              size: 15,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ((specialoffer.price! / 115).round())
                                      .toString()
                                      .toPersianDigit()
                                      .seRagham() +
                                  " هدیه نقدی",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontFamily: 'iranyekan',
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                  letterSpacing: 0,
                                  wordSpacing: 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              CupertinoIcons.gift,
                              color: Colors.purple,
                              size: 15,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SingleProduct(specialoffer);
                    }));
                  },
                  child: Image.asset(
                    "assets/images/" + specialoffer.image!,
                    width: 110,
                    height: 110,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ((specialoffer.price! - specialoffer.off_price!) *
                                      count)
                                  .toString()
                                  .toPersianDigit()
                                  .seRagham() +
                              " تومان تخفیف",
                          style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                            Text(
                              ((specialoffer.off_price!) * count)
                                  .toString()
                                  .toPersianDigit()
                                  .seRagham(),
                              style: TextStyle(
                                fontFamily: 'iranyekan',
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 105,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        showIcon(count, index),
                        Text(
                          count.toString().toPersianDigit(),
                          style: TextStyle(
                            fontFamily: 'iranyekan',
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (count <= 9) {
                                  basket[index][1] += 1;
                                  count += 1;
                                  // order[basket[index][0]] = count;
                                  addToCart(basket[index][0]);
                                }
                              });
                            },
                            icon: Icon(
                              CupertinoIcons.add,
                              color: Colors.red,
                              size: 24,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  IconButton showIcon(int count, int index) {
    if (count >= 2) {
      return IconButton(
        onPressed: () {
          setState(() {
            basket[index][1] -= 1;
            count -= 1;
            // order[basket[index][0]] = count;
            addToCart(basket[index][0], -1);
          });
        },
        icon: Icon(
          Icons.remove,
          color: Colors.red,
        ),
      );
    } else {
      return IconButton(
        onPressed: () {
          setState(() {
            // if (count != 0) {
            // basket[index][1] -= 1;
            count -= 1;
            // order[basket[index][0]] = count;
            // addToCart(basket[index][0],-1);
            // }
            // if (count == 0) {
            basket[index][0].isAdded = false;
            order.remove(basket[index][0]);
            basket.removeAt(index);
            baskets!.add(basket);
            // }
          });
        },
        icon: Icon(
          CupertinoIcons.delete,
          color: Colors.red,
          size: 20,
        ),
      );
    }
  }
}
