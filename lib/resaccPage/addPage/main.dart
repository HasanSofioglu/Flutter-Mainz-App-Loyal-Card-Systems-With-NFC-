import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formainz/resaccPage/data/basketdata.dart';
import 'package:formainz/resaccPage/data/data.dart';
import 'package:formainz/resaccPage/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddPage extends StatefulWidget {
  String idRest;
  String typeSelect;
  AddPage({Key key, @required this.idRest, this.typeSelect}) : super(key: key);
  @override
  _AddPageState createState() => _AddPageState(idRest, typeSelect);
}

class _AddPageState extends State<AddPage> {
  String typeSelect;
  final stars = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  String idRest;
  String value = "1";
  File file;
  String _imageurl;
  FirebaseAuth _auth = FirebaseAuth.instance;

  _AddPageState(String idRest, String typeSelect);

  bool showPassword = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _tagline = TextEditingController();
  final TextEditingController _price = TextEditingController();

  UploadTask task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Add Product",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (file != null)
                                    ? FileImage(File(file.path))
                                    : AssetImage("assets/dd.png")))),
                    Positioned(
                        bottom: 0,
                        right: 10,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 17,
                            ),
                            onPressed: () {
                              selectFile();
                            },
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Product Name", "Caffee", false, _name),
              buildTextField("Description", "Ground and mixed with milk", false,
                  _description),
              buildTextField("Tagline", "Delicious", false, _tagline),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Price",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "\$",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  controller: _price,
                ),
              ),
              if (CatalogModel.selectType == "1")
                Column(
                  children: [
                    Text(
                        "Number of stars: \n*Shows buying how many coffees  after the customer will earn coupons."),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: value,
                              iconSize: 36,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue,
                              ),
                              isExpanded: true,
                              items: stars.map(buildStarsItem).toList(),
                              onChanged: (value) =>
                                  setState(() => this.value = value)),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_name.text != null &&
                          _description.text != null &&
                          _tagline.text != null &&
                          _price.text != null) {
                        await uploadFile();
                        FirebaseFirestore _firestore =
                            FirebaseFirestore.instance;

                        await _firestore
                            .collection("products")
                            .add({}).then((value) {
                          Navigator.pop(context);
                          var collection = _firestore.collection('products');
                          collection.doc(value.id) // <-- Document ID
                              .set({
                            'id': value.id,
                            "restID": _auth.currentUser.uid,
                            "name": _name.text,
                            "description": _description.text,
                            "tagLine": _tagline.text,
                            "image": _imageurl,
                            "price": _price.text,
                            if (CatalogModel.selectType == "1")
                              "stars": this.value
                          }) // <-- Your data
                              .then((_) {
                            setState(() {
                              shoesData.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => RestAccpage(
                                            idRest: CatalogModel.idRest,
                                            typeSelect: this.value,
                                          )));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("add succesful"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      task != null
                                          ? buildUploadStatus(task)
                                          : Container(),
                                      new FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          }).catchError((error) => print('Add failed: $error'));
                          print(value.id);
                        }).catchError((error) => print(error));
                      }
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 70),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildStarsItem(String stars) => DropdownMenuItem(
      value: stars,
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.blue,
          ),
          Text(
            stars,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ));
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    _imageurl = urlDownload;
    print('Download-Link: $urlDownload');
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, final TextEditingController _text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        controller: _text,
      ),
    );
  }
}

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);

          return Text(
            '$percentage %',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        } else {
          return Container();
        }
      },
    );

class FirebaseApi {
  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
