import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formainz/main.dart';


Future<User> createAccount(String name, String email, String password,
    String status, String number, String shopName,String location) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if ( null) {
      if (status == "Rest") {
        print("Account created Succesfull");

        await _firestore.collection('users').doc(_auth.currentUser.uid).set({
          "ID": _auth.currentUser.uid,
          "name": name,
          "email": email,
          "status": status,
          "shopName": shopName,
          "shopNumber": number,
          "location": location,
        });
      }
      if (status == "Normal") {
        print("Account created Succesfull");

        await _firestore.collection('users').doc(_auth.currentUser.uid).set({
          "ID": _auth.currentUser.uid,
          "name": name,
          "email": email,
          "status": status,
        });
      }

      return user;
    } else {
      print("Account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User> logIn(String email, String password, String userId) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) => user.updateProfile(displayName: value['status']));

      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  } catch (e) {
    print("error");
  }
}

loginController(String contrroler) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  await _firestore
      .collection("users")
      .where("email", isEqualTo: contrroler)
      .get()
      .then((usersInfo) {
    contrroler = usersInfo.docs[0].data()['name'];
  });
  print(contrroler);

  return contrroler;
}
