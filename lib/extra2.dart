import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'main.dart';
import 'package:f1/Models/specialOffers.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: Colors.red,
          title: Text("DigiKala"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
          ],
          elevation: 0,
        ),
        body: FutureBuilder<List<SpecialOffers>>(
          future: specialOfferFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<SpecialOffers>? specialOfferFuture = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              (specialOfferFuture!.length * 223)
                                  .toString()
                                  .toPersianDigit()
                                  .seRagham(),
                              style: TextStyle(
                                  fontFamily: 'iranyekan',
                                  fontSize: 11,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w100),
                            ),
                            Spacer(),
                            Text("فروش ویژه",
                                style: TextStyle(
                                    fontFamily: 'iranyekan',
                                    fontSize: 11,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w100))
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 3,
                      color: Colors.red,
                      thickness: 3,
                      endIndent: 10,
                      indent: 10,
                    ),
                    GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                mainAxisExtent: 175),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return showSpecialOfferGridView(
                              specialOfferFuture![index]);
                          // return Container(
                          //   color: Colors.amber,
                          // );
                        },
                        itemCount: 8,
                        scrollDirection: Axis.vertical),
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
        ));
  }
}

Container showSpecialOfferGridView(SpecialOffers specialoffer) {
  return Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, right: 20, left: 10, bottom: 10),
            child: Column(
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
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          specialoffer.star.toString().toPersianDigit(),
                          style: TextStyle(
                              fontFamily: 'iranyekan',
                              fontSize: 11,
                              color: Colors.black54,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    Row(
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
                              fontSize: 11,
                              color: Colors.black54,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          "assets/images/cash.png",
                          height: 15,
                          width: 15,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed:(){}, icon:Icon(Icons.bookmark_border)),
                    ElevatedButton(
                      onPressed: (){}, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:EdgeInsets.all(5), 
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.add_shopping_cart,size:20,),
                          Text(" افزودن به سبد خرید",style: TextStyle(
                                fontFamily: 'iranyekan',
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                                )
                          )
                        ],
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Image.asset(
          "assets/images/" + specialoffer.image!,
          width: 125,
          height: 125,
          fit: BoxFit.fill,
        ),
      ],
    ),
  );
}
