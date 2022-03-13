import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formainz/resaccPage/data/basketdata.dart';
import 'package:formainz/resaccPage/data/data.dart';
import 'package:formainz/resaccPage/editPage/main.dart';
import 'package:formainz/resaccPage/main.dart';
import 'package:formainz/resaccPage/widgets/custom_icon_button.dart';
//import 'package:settings_ui/constants/constants.dart';

//import 'package:settings_ui/widgets/custom_icon_button.dart';
//import 'package:settings_ui/widgets/like_button.dart';

class DetailScreen extends StatefulWidget {
  final ShoeData shoeData;
  final String tag;
  DetailScreen({this.shoeData, this.tag});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Widget _buildSizeTags(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // _selectedTag = index;
        });
      },
      child: Container(
        width: 50,
        decoration: BoxDecoration(
          // color: _selectedTag == index ? AppColor.PRIMARY_COLOR : Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            /* child: Text(
            _sizeTags[index],
            style: TextStyle(
              color: _selectedTag != index ? Colors.grey[400] : Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          */
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: widget.shoeData.backgroundColor,
                      ),
                      child: Hero(
                          tag: "${widget.shoeData.id}",
                          child: Image.network('${widget.shoeData.image}')),
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);

                            build(context);
                          });
                        }),
                    /*Positioned(
                      right: 10,
                      top: 10,
                      //child: likeButton(),
                    ),*/
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.shoeData.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(widget.shoeData.tagLine,
                    style: Theme.of(context).textTheme.headline2),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    //itemCount: _sizeTags.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          _buildSizeTags(index),
                          SizedBox(width: 10),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 1),
                Text("Description",
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(
                  height: 10,
                ),
                Text(widget.shoeData.description,
                    style: Theme.of(context).textTheme.headline2),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Product ID: ${widget.shoeData.id}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black)),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  MaterialButton(
                    minWidth: 200,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPage(
                                    idRest: widget.shoeData.id,
                                    shoeData: widget.shoeData,
                                  )));
                    },
                    color: Colors.lightGreen,
                    // defining the shape
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.lightGreen),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  MaterialButton(
                    height: 60,
                    onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Are You Sure"),
                              content: new Text(
                                  " Do you want to Delete named ${widget.shoeData.id} product?"),
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
                                    DocumentReference documentReference =
                                        FirebaseFirestore.instance
                                            .collection("products")
                                            .doc('${widget.shoeData.id}');
                                    documentReference.delete();

                                    shoesData.clear();
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RestAccpage(
                                                    idRest: CatalogModel.idRest,
                                                    typeSelect:
                                                        CatalogModel.selectType,
                                                  )));
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            title: new Text("Delete"),
                                            content: new Text("succesfly"),
                                            actions: <Widget>[
                                              // usually buttons at the bottom of the dialog
                                              new FlatButton(
                                                child: new Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                    color: Colors.redAccent,

                    // defining the shape
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ]),
                /* Text("Reviews", style: Theme.of(context).textTheme.headline5),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/people1.jpg'),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/people2.jpg'),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/people3.jpg'),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              child: CircleAvatar(
                                backgroundColor: Colors.black87,
                                child: Text("12+",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    customIconButtom(
                      backgroundColor: AppColor.PRIMARY_COLOR,
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                      onTap: () {},
                      radius: BorderRadius.circular(25),
                    )
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
