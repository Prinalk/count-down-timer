import 'package:flutter/material.dart';

heightSpace({required double height}){
  return SizedBox(
    height: height,
  );
}

widthSpace({required double width}){
  return SizedBox(
    width: width,
  );
}
height(BuildContext context){
  return MediaQuery.of(context).size.height;
}
width( BuildContext context){
  return MediaQuery.of(context).size.width;
}
