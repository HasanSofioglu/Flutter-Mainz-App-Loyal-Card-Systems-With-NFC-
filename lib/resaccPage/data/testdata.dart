import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class BookingList {
  String bookingId;
  String userId;

  BookingList({
    this.bookingId,
    this.userId,
  });

  BookingList.fromJson(Map<String, dynamic> json) {
    bookingId = json['description'];
    userId = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.bookingId;
    data['name'] = this.userId;

    return data;
  }
}

List<BookingList> productData = [];
