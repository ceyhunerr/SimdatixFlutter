import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simdatixtest/style/renkler.dart';

class Taslak{
  loading(Size size) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height*0.15),
        height: size.height*0.045,
        //width: size.height*0.01,
        child: LottieBuilder.asset("assets/load.json"),
      ),
    );
  }
  
 String temizle(String string){

    return string.split("[").last.split("]").first.replaceAll(",", " -");
 }

}