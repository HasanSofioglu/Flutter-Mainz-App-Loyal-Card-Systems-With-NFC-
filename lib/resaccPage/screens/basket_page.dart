import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:formainz/resaccPage/constants/constants.dart';
import 'package:formainz/resaccPage/data/basketdata.dart';
import 'package:formainz/resaccPage/data/data.dart';
import 'package:formainz/resaccPage/data/flutter_nfc_reader.dart';
import 'package:formainz/resaccPage/main.dart';

import 'package:formainz/resaccPage/widgets/custom_icon_button.dart';
import 'package:formainz/resaccPage/widgets/item_Widget.dart';

import 'package:flutter/cupertino.dart';

class basketPage extends StatefulWidget {
  String idRest;
  basketPage({Key key, @required this.idRest}) : super(key: key);
  @override
  basketPageState createState() => basketPageState(idRest);
}

class basketPageState extends State<basketPage> {
  String idRest;
  basketPageState(this.idRest);
  int price = 0;
  BasketData bascontroller;

  int pricecontroller;
  bool _loading = false;
  Map<String, dynamic> userMap;
  TextEditingController writerController = TextEditingController();
  final TextEditingController _tPrice = TextEditingController();
  @override
  initState() {
    super.initState();
    writerController.text = 'NFC Scan';
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      print(onData.content);
    });
  }

  void onSearch(String nfcID) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      _loading = true;
    });
    await _firestore
        .collection("users")
        .where("id", isEqualTo: nfcID)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        _loading = false;
      });
      print(userMap);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    writerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            new Spacer(),
            Icon(
              Icons.shopping_basket_sharp,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Basket",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: CatalogModel.BasketsData.length,
                  itemBuilder: (context, index) {
                    print(CatalogModel.ptotal);

                    return Column(
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        getBasktes(context, CatalogModel.BasketsData[index]),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }

  Widget getBasktes(BuildContext context, BasketData item) {
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
                    new Spacer(),
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      new Spacer(),
                      Text(
                        "Total:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "\$${CatalogModel.ptotal}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  TextField(
                    controller: writerController,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  scanIconButtom(
                    onTap: () {
                      _loading = true;
                      setState(() {
                        FlutterNfcReader.read(instruction: "It's reading");
                        FlutterNfcReader.read().then((response) {
                          writerController.text = response.id;
                          onSearch(response.id);
                          if (userMap["id"] == response.id) {
                            setState(() {
                              build(context);
                              _loading = false;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("${userMap["email"]}"),
                                    content: new Text(
                                        " Orders are entered by the  " +
                                            "${userMap["name"]}"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      new FlatButton(
                                        child: new Text("Yes"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  title: new Text(
                                                      "order completed"),
                                                  content: new Icon(
                                                    Icons.check_circle,
                                                    size: 150,
                                                  ),
                                                  actions: <Widget>[
                                                    // usually buttons at the bottom of the dialog
                                                    new FlatButton(
                                                      child: new Text("Close"),
                                                      onPressed: () {
                                                        CatalogModel.ptotal = 0;
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          });

                                          CatalogModel.BasketsData.clear();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          }
                          print("${response.id}" + "testmode");
                        });
                      });
                    },
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
              ),
            ),
          ),
      ],
    );
  }
}
