import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simdatixtest/provider/apiClient.dart';
import 'package:simdatixtest/provider/userProvider.dart';
import 'package:simdatixtest/src/home.dart';
import 'package:simdatixtest/src/tickets.dart';
import 'package:simdatixtest/style/renkler.dart';
import 'package:simdatixtest/style/svgler.dart';
import 'package:simdatixtest/widget/loginWidget.dart';

class HomeNav extends StatelessWidget {

  Renkler renkler = Renkler();
  Svgler svgler = Svgler();

  List<Widget> list = [
    Home(),
    Tickets(),
  ];



  @override
  Widget build(BuildContext context) {
    var state =Provider.of<UserControl>(context);
    Provider.of<UserControl>(context,listen: false).userControl();

    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          body: list.elementAt(state.count),
          bottomNavigationBar:Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: size.height*0.1,
            child: Row(
              children: [
                _item(size,"Homescreen",0,svgler.home,state),
                _item(size,"Tickets",1,svgler.tickets,state),
              ],
            ),
          ),
        ),
        state.loginWidget==false?LoginWidget():SizedBox(),
      ],
    );
  }

  _item(Size size, String title, int i, String svg, UserControl state) {
    return Expanded(
        child: GestureDetector(
          onTap: (){
            if(i==1){
              if(state.userCheck==false){
                state.changeLogin(false);
              }else{
                state.change(i);
              }
            }else{
              state.change(i);

            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.string(svg,color: state.count==i?renkler.turuncu:renkler.unSelected,),
              SizedBox(width: size.height*0.024,),
              Text(title,style: TextStyle(color: state.count==i?renkler.turuncu:renkler.unSelected, ),)
            ],
          ),
        )
    );
  }



}


