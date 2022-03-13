import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int rating;

  const RatingBar({Key key, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int doluyildiz = 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (doluyildiz < rating) {
          doluyildiz++;
          return Icon(
            Icons.star,
            color: Colors.yellow,
            size: 30,
          );
        } else {
          return Icon(
            Icons.star_border_outlined,
            color: Colors.yellow,
            size: 30,
          );
        }
      }),
    );
  }
}
