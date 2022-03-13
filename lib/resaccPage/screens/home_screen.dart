import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formainz/resaccPage/addPage/main.dart';
import 'package:formainz/resaccPage/constants/constants.dart';
import 'package:formainz/resaccPage/data/data.dart';
import 'package:formainz/resaccPage/data/testdata.dart';
import 'package:formainz/resaccPage/screens/basket_page.dart';
import 'package:formainz/resaccPage/screens/profile/profile/profile_screen.dart';
import 'package:formainz/resaccPage/widgets/custom_icon_button.dart';
import 'package:formainz/resaccPage/widgets/shoe_card.dart';
import 'package:http/http.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  String userId;
  String typeSelect;
  HomeScreen({Key key, @required this.userId, this.typeSelect})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState(userId, typeSelect);
}

class _HomeScreenState extends State<HomeScreen> {
  String userId;
  String typeSelect;
  @override
  void initState() {
    onInfo();
    super.initState();
  }

  onInfo() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("products")
        .where("restID", isEqualTo: userId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        shoesData.add(ShoeData.fromJson(Map<String, dynamic>.from(doc.data())));
      });

      setState(() {
        build(context);
      });
    });
  }

  _HomeScreenState(this.userId, String typeSelect);
  //List<String> _tags = ["All", "Shoes", "Bags", "Clothing", "Cap"];
  //int _selectedTag = 0;

  /*Widget _buildTags(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTag = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: _selectedTag == index ? AppColor.PRIMARY_COLOR : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        /*child: Text(
          _tags[index],
          style: TextStyle(
            color: _selectedTag != index ? Colors.grey[400] : Colors.white,
            fontFamily: 'Poppins',
          ),
        ),*/
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileRestScreen()));
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                              image: DecorationImage(
                                image: AssetImage('assets/dd.png'),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0.0, 4),
                                    blurRadius: 10.0)
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 10,
                        child: Icon(
                          Icons.more_vert,
                          size: 30,
                        ),
                      )
                    ]),
                Text(
                  "Welcome to Your Shop !",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  "Products in my shop",
                  style: Theme.of(context).textTheme.headline2,
                ),
                customIconButtom(
                  height: 60,
                  width: 60,
                  backgroundColor: AppColor.SECONDARY_COLOR,
                  child: Image.asset('assets/coffeebasket.png'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => basketPage(
                                  idRest: userId,
                                )));
                  },
                  radius: BorderRadius.circular(12),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            labelText: "Search",
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: AppColor.SECONDARY_COLOR,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    customIconButtom(
                      backgroundColor: AppColor.SECONDARY_COLOR,
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/icons/filter.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPage(
                                      idRest: userId,
                                      typeSelect: typeSelect,
                                    )));
                      },
                      radius: BorderRadius.circular(12),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _tags
                      .asMap()
                      .entries
                      .map((MapEntry map) => _buildTags(map.key))
                      .toList(),
                ),*/
                _shoeListView(),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shoeListView() {
    return shoesData != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: shoesData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            shoeData: shoesData[index],
                          ),
                        ),
                      );
                    },
                    child: ShoeCard(
                      shoe: shoesData[index],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            })
        : Container();
  }
}
