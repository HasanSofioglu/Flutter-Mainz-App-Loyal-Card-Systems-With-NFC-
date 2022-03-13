import 'package:flutter/material.dart';

class ShoeData {
  String id;
  String name;
  String description;
  String price;
  String image;
  Color backgroundColor;
  String tagLine;

  ShoeData(
      {this.description,
      this.id,
      this.image,
      this.name,
      this.price,
      this.tagLine,
      
      this.backgroundColor});
  ShoeData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    id = json['id'];
    image = json['image'];
    price = json['price'];
    tagLine = json['tagLine'];
    backgroundColor = json['backgroundColor'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['name'] = this.name;
    data['id'] = this.id;
    data['image'] = this.image;
    data['price'] = this.price;
    data['tagLine'] = this.tagLine;
    data['backgroundColor'] = this.backgroundColor;

    return data;
  }
}

List<ShoeData> shoesData = [];

