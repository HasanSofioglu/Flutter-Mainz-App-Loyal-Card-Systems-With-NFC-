import 'package:flutter/material.dart';
import 'package:formainz/resaccPage/constants/constants.dart';

import 'package:formainz/resaccPage/data/basketdata.dart';
import 'package:formainz/resaccPage/screens/basket_page.dart';

import 'custom_icon_button.dart';

class ItemWidget extends StatefulWidget {
  final BasketData item;
  const ItemWidget({Key key, @required this.item})
      : assert(item != null),
        super(key: key);
  @override
  ItemWidgetPageState createState() => ItemWidgetPageState(item);
}

class ItemWidgetPageState extends State<ItemWidget> {
  BasketData item;

  ItemWidgetPageState(this.item);
  BasketData bascontroller;
  int pricecontroller;

  final TextEditingController _tPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    pricecontroller = item.price;
    _tPrice.text = CatalogModel.ptotal.toString();
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    customIconButtom(
                      backgroundColor: AppColor.SECONDARY_COLOR,
                      height: 50,
                      width: 50,
                      child: Icon(Icons.exposure_minus_1_outlined),
                      onTap: () {
                        setState(() {
                          if (item.units == 1) {
                          } else {
                            for (var i = 0;
                                i < CatalogModel.BasketsData.length;
                                i++) {
                              if (CatalogModel.BasketsData[i] == item) {
                                bascontroller = CatalogModel.BasketsData[i];

                                bascontroller.units--;
                                bascontroller.priceTotal =
                                    bascontroller.units * pricecontroller;
                                CatalogModel.ptotal -= item.price;
                                _tPrice.text = CatalogModel.ptotal.toString();
                                CatalogModel.BasketsData[i] = bascontroller;
                              }
                            }
                            build(context);
                          }
                        });
                      },
                      radius: BorderRadius.circular(12),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "< ",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "${item.units}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "> ",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 5),
                    customIconButtom(
                      backgroundColor: AppColor.SECONDARY_COLOR,
                      height: 50,
                      width: 50,
                      child: Icon(Icons.plus_one),
                      onTap: () {
                        setState(() {
                          for (var i = 0;
                              i < CatalogModel.BasketsData.length;
                              i++) {
                            if (CatalogModel.BasketsData[i] == item) {
                              bascontroller = CatalogModel.BasketsData[i];

                              bascontroller.units++;
                              bascontroller.priceTotal =
                                  bascontroller.units * pricecontroller;
                              CatalogModel.ptotal += item.price;
                              _tPrice.text = CatalogModel.ptotal.toString();
                              CatalogModel.BasketsData[i] = bascontroller;
                            }
                          }

                          build(context);
                        });
                      },
                      radius: BorderRadius.circular(12),
                    ),
                    customIconButtom(
                      backgroundColor: AppColor.SECONDARY_COLOR,
                      height: 50,
                      width: 50,
                      child: Icon(Icons.delete),
                      onTap: () {},
                      radius: BorderRadius.circular(12),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    print("${item.name} pressed");
                  },
                  leading: Image.network(item.image),
                  title: Text(item.name),
                  subtitle: Text("id:" + item.id),
                  trailing: Column(
                    children: [
                      Text(
                        "\$${item.units * item.price}",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (CatalogModel.BasketsData[CatalogModel.BasketsData.length - 1] ==
            item)
          scanIconButtom(
            onTap: () {},
            backgroundColor: Colors.black,
            // defining the shape

            child: Row(children: [
              Icon(
                Icons.nfc_rounded,
                color: Colors.white,
                size: 50,
              ),
              Spacer(),
              Text(
                "Scan Card",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ]),
            radius: BorderRadius.circular(12),
          ),
      ],
    );
  }
}
