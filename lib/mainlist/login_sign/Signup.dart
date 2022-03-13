import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:formainz/mainlist/map/main.dart';
import 'package:formainz/resaccPage/data/basketdata.dart';
import 'package:formainz/resaccPage/data/data.dart';
import 'package:formainz/resaccPage/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constants.dart';
import '../main.dart';
import 'Methods.dart';
import 'package:firebase_core/firebase_core.dart';

class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

String _location;

class SignupPageState extends State<SignupPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwortry = TextEditingController();
  final TextEditingController _shopName = TextEditingController();
  final TextEditingController _shopNumber = TextEditingController();
  final TextEditingController _price = TextEditingController();

  bool _rememberMe = false;
  int _valueRadio = 1;
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _name,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.account_balance,
                  color: Colors.white,
                ),
                hintText: 'Enter your Name',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: 'Enter your Email',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: controller,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  print(_location);
                  _rememberMe = value;
                  build(context);
                });
              },
            ),
          ),
          Text(
            'I own a restaurant',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildrestbox(bool controller) {
    return Visibility(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.black,
            child: Text(
              'Add Location',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _shopName,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.store,
                  color: Colors.white,
                ),
                hintText: 'Enter your Shop Name',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _shopNumber,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                hintText: 'Enter your Phone Number',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                Radio(
                    value: 1,
                    groupValue: _valueRadio,
                    onChanged: (value) {
                      setState(() {
                        _valueRadio = value;
                      });
                    }),
                Text("Stars System")
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 2,
                    groupValue: _valueRadio,
                    onChanged: (value) {
                      setState(() {
                        _valueRadio = value;
                      });
                    }),
                Text("Money Sistem")
              ],
            ),
          ],
        ),
        if (_valueRadio == 2)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Limit: ",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "\$",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    controller: _price),
              ),
              Row(
                children: [
                  Text(
                      "*Shopping limit to earn coupons\n *If you want to change after making \nthe selection, you must delete all products."),
                ],
              )
            ],
          ),
      ]),
      visible: controller,
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (_name.text.isNotEmpty &&
              _email.text.isNotEmpty &&
              _password.text.isNotEmpty &&
              _password.text == _passwortry.text) {
            setState(() {
              _isLoggedIn = true;
            });
            if (_rememberMe == false) {
              createAccount(_name.text, _email.text, _password.text, "Normal",
                      "a", "b", "c", "d", "e")
                  .then((user) {
                if (user != null) {
                  setState(() {
                    _isLoggedIn = false;
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MainListPage(
                                nameText: _name.text,
                              )));
                  print("Created Sucessfull");
                } else {
                  print("Created Sucessfull but Login Failed");
                  setState(() {
                    _isLoggedIn = false;
                  });
                }
              });
            }
            if (_rememberMe == true && _location != null && _price != null) {
              createAccount(
                      _name.text,
                      _email.text,
                      _password.text,
                      "Rest",
                      _shopNumber.text,
                      _shopName.text,
                      _location,
                      _valueRadio.toString(),
                      _price.text)
                  .then((user) {
                if (user != null) {
                  setState(() {
                    _isLoggedIn = false;
                  });
                  shoesData.clear();
                  CatalogModel.selectType = "";
                  CatalogModel.idRest = user.uid;
                  CatalogModel.selectType = _valueRadio.toString();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RestAccpage(
                                idRest: user.uid,
                                typeSelect: _valueRadio.toString(),
                              )));
                  print("Created Sucessfull");
                } else {
                  print("Created Sucessfull but Login Failed");
                  setState(() {
                    _isLoggedIn = false;
                  });
                }
              });
            }
          } else {
            print("Please enter Fields");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Signup Failed"),
                  content: new Text(
                      "Please fill in all fields. If you are a restaurant owner, you need to determine your location."),
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
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.purple,
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildNameTF(),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(_password),
                      _buildPasswordTF(_passwortry),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildRememberMeCheckbox(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildrestbox(_rememberMe),
                      _buildLoginBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_navigateAndDisplaySelection(BuildContext context) async {
  final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => MapPage()));

  _location = result;
}
