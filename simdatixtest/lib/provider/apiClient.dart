// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simdatixtest/model/ticketModel.dart';
import 'package:simdatixtest/model/timeListModel.dart';
import 'package:simdatixtest/style/apiUrl.dart';
enum Status{Sabit,Bekliyor,Yuklendi,Hata}

class ApiClient with ChangeNotifier{
    TicketModel _model=TicketModel();
   Status _status = Status.Sabit;

  List<TimeListModel> _list=[];

  Status get status=>_status;

  List<TimeListModel> get list=>_list;
    TicketModel get model => _model;


 Future getTimeList(BuildContext context)async{
   _status=Status.Bekliyor;
   _list.clear();
try{
  var response = await http.get(Uri.parse(
      ApiUrl().departureTimesUrl));
  final jsondata = json.decode(response.body);
  for(var key in jsondata["data"]){
    TimeListModel model = TimeListModel.fromJson(key);
    _list.add(model);
    _status=Status.Yuklendi;
  }
}catch(e){
  _status=Status.Hata;
  return list;
}
   notifyListeners();
  }

  Future getData()async{


  try{
    SharedPreferences bilgi = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(
        ApiUrl().TicketsUrl+bilgi.getString("id").toString()+"/ticket"));
    final jsondata = json.decode(response.body);
    _model=TicketModel.fromJson(jsondata["data"]);

  }catch(e){
   print(e);

  }

    notifyListeners();
 }
}