import 'package:flutter/material.dart';

Widget customIconButtom(
    {Widget child,
    Function onTap,
    Color splashColor,
    Color backgroundColor,
    Size size,
    double width,
    double height,
    BorderRadius radius}) {
  return InkWell(
    borderRadius: radius,
    splashColor: splashColor,
    onTap: onTap,
    child: Ink(
        padding: EdgeInsets.all(15),
        width: width,
        height: height,
        decoration: new BoxDecoration(
          color: backgroundColor,
          borderRadius: radius,
        ),
        child: child),
  );
}

Widget scanIconButtom(
    {Widget child,
    Function onTap,
    Color splashColor,
    Color backgroundColor,
    BorderRadius radius}) {
  return InkWell(
    borderRadius: radius,
    splashColor: splashColor,
    onTap: onTap,
    child: Ink(
        padding: EdgeInsets.all(15),
        decoration: new BoxDecoration(
          color: backgroundColor,
          borderRadius: radius,
        ),
        child: child),
  );
}
