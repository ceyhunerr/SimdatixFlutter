import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simdatixtest/model/timeListModel.dart';
import 'package:simdatixtest/provider/apiClient.dart';
import 'package:simdatixtest/provider/userProvider.dart';
import 'package:simdatixtest/style/renkler.dart';
import 'package:simdatixtest/style/svgler.dart';
import 'package:simdatixtest/style/taslak.dart';

class HomeWidget{
  timeListBuilder(BuildContext context, Size size,List<TimeListModel> list )  {

    return Container(
      child: ListView.separated(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: size.height*0.027),
        itemCount:list.length,
          shrinkWrap: true,
          itemBuilder:(BuildContext context,index){
            var data = list[index];
        return Row(
          children:[
            SvgPicture.string(data.tourType.toString()=="Day"?Svgler().sun:Svgler().moon),
            SizedBox(width: size.height*0.02,),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data.route} / ${data.arrivalTime}-${data.departureTime}",style: TextStyle(color: Renkler().siyah,fontSize: size.height*0.024,fontWeight: FontWeight.w700 ),),
              Text(Taslak().temizle(data.daysOfWeek!.map((e) =>e).toList().toString()),style: TextStyle(color: Renkler().siyah,fontSize: size.height*0.024,fontWeight: FontWeight.w400 ),)

            ,

            ],
          ),
          ]
        );
      },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Renkler().gri,height: size.height*0.050,thickness: 1,);
        },),
    );
  }

}