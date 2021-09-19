// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:simdatixtest/provider/userProvider.dart';
import 'package:simdatixtest/style/renkler.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  TextEditingController email = TextEditingController();
  TextEditingController sifre = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Renkler renkler = Renkler();
    Size size = MediaQuery.of(context).size;
    var userProvider = Provider.of<UserControl>(context);

    return GestureDetector(
       onTap: (){
         userProvider.changeLogin(true);
       },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.50),
        body: Center(
          child: GestureDetector(
            onTap: (){},
            child: Container(
              height: size.height*0.5,
              width: size.width*0.9,
              decoration: BoxDecoration(
                  color: renkler.beyaz,
                  borderRadius: BorderRadius.circular(size.height*0.024)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height*0.024),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: size.height*0.028,),
                    Column(
                      children: [
                        Text("Welcome back!",style: TextStyle(color: renkler.siyah,fontWeight: FontWeight.w700,fontSize: size.height*0.028),),
                        Text(userProvider.hataMesaj,style: TextStyle(color: renkler.kirmizi,fontWeight: FontWeight.w500,fontSize: size.height*0.018),),
                      ],
                    ),
                    //SizedBox(height: size.height*0.024,),
                    _textEdit("Email",email,size,renkler,context),
                    //SizedBox(height: size.height*0.028,),
                    _textEdit("Password",sifre,size,renkler,context),
                    MaterialButton(
                      minWidth: size.width*0.4,
                      onPressed: (){
                       // userProvider.savePreferences("bac96e9b-717b-40b5-8198-6bfe84fbe081");
                       userProvider.login(email.text.toString(), sifre.text.toString());
                      },
                      color: renkler.turuncu,
                      child: Text("LOG IN",style: TextStyle(color: renkler.beyaz,fontSize: size.height*0.02,fontWeight: FontWeight.w700),),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(size.height*0.1)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _textEdit(String hint, TextEditingController controller, Size size, Renkler renkler,BuildContext context) {
    loginStatus check = Provider.of<UserControl>(context).durum;

    return TextField(
      controller: controller,
      cursorColor: renkler.turuncu,
      obscureText: hint=="Password"?true:false,
      style: TextStyle(
          color: renkler.siyah, fontFamily: "Medium", fontSize: size.height*0.02),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            height: MediaQuery.of(context).size.height*0.001,
            color: renkler.gri,
            fontFamily: "Medium",
            fontSize: size.height*0.018),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(size.height*0.015),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:check==loginStatus.hata?renkler.kirmizi: renkler.gri,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: check==loginStatus.hata?renkler.kirmizi: renkler.turuncu,
            )),

      ),);
  }
}
