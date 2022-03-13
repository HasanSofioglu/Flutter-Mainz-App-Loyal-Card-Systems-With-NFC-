import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formainz/resaccPage/constants/constants.dart';
import 'package:formainz/resaccPage/data/basketdata.dart';
import 'package:formainz/resaccPage/data/data.dart';

import 'custom_icon_button.dart';

//import 'package:settings_ui/widgets/custom_buy_button.dart';
//import 'package:settings_ui/widgets/like_button.dart';

class ShoeCard extends StatelessWidget {
  final ShoeData shoe;

  const ShoeCard({Key key, this.shoe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasketData shoeContraller;
    bool basketcontroller = false;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      height: 150,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 130,
                    width: 140,
                    child: Hero(
                      tag: "${shoe.id}",
                      child: Image.network('${shoe.image}'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: shoe.name,
                    style: Theme.of(context).textTheme.headline4,
                    /*children: <TextSpan>[
                      TextSpan(
                        text: '\nby Nike',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],*/
                  ),
                ),
                Text(
                  shoe.tagLine,
                  style: Theme.of(context).textTheme.caption,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$\ ${shoe.price}",
                        style: Theme.of(context).textTheme.headline4),
                    // customBuyButtom()
                    MaterialButton(
                      height: 60,
                      minWidth: 60,
                      splashColor: Colors.blueAccent,
                      child: Icon(
                        Icons.shopping_basket_sharp,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        for (var i = 0;
                            i < CatalogModel.BasketsData.length;
                            i++) {
                          shoeContraller = CatalogModel.BasketsData[i];
                          if (shoeContraller.id == shoe.id) {
                            shoeContraller.units++;
                            shoeContraller.priceTotal =
                                shoeContraller.units * int.parse(shoe.price);
                            basketcontroller = true;
                            break;
                          }
                        }
                        if (basketcontroller == false) {
                          CatalogModel.BasketsData.add(
                            BasketData(
                                id: shoe.id,
                                name: shoe.name,
                                price:  int.parse(shoe.price),
                                image: shoe.image,
                                desc: shoe.description,
                                units: 1,
                                priceTotal: int.parse(shoe.price)),
                          );
                        }

                        CatalogModel.ptotal = CatalogModel.ptotal + int.parse(shoe.price) ;
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
