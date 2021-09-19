import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simdatixtest/model/timeListModel.dart';
import 'package:simdatixtest/provider/apiClient.dart';
import 'package:simdatixtest/provider/userProvider.dart';
import 'package:simdatixtest/style/renkler.dart';
import 'package:simdatixtest/style/svgler.dart';
import 'package:simdatixtest/style/taslak.dart';
import 'package:simdatixtest/widget/HomeWidget.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Renkler renkler = Renkler();
  Svgler svgler = Svgler();
  String image ="https://images.unsplash.com/photo-1528728329032-2972f65dfb3f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=80";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      getHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<TimeListModel> list = Provider.of<ApiClient>(context).list;

    return Scaffold(
      appBar: _appBar(size),
      backgroundColor: renkler.back,
      body:list.isEmpty?Taslak().loading(size):  ListView(
        physics: BouncingScrollPhysics(),
        children: [

          Container(
            color: renkler.beyaz,
              padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.024,),
                Center(
                  child: SizedBox(
                      height: size.height*0.25,
                    width: size.width*1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(size.height*0.020),
                      child: Image.network("$image",fit: BoxFit.cover,),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height*0.024,bottom: size.height*0.012),
                  child: Text("Departure Times",style: TextStyle(color: renkler.siyah,fontSize: size.height*0.028,fontWeight: FontWeight.w700),),
                ),
              ],
            ),
          ),
          HomeWidget().timeListBuilder(context,size,list),
        ],
      ),

    );
  }

  _appBar(Size size) {
    return AppBar(
      toolbarHeight: size.height*0.13,
      backgroundColor: renkler.turuncu,
      centerTitle: true,
      title: Text("TEST APP",style: TextStyle(color: Colors.white,fontSize: size.height*0.024,fontWeight: FontWeight.w600),),
      leading:Padding(
          padding: EdgeInsets.all(size.height*0.03),
          child: SvgPicture.string(svgler.bus)),
    );
  }

  void getHomeData()async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      ApiClient apiClient = Provider.of<ApiClient>(context,listen: false);
      await apiClient.getTimeList(context);
    });
  }


}



