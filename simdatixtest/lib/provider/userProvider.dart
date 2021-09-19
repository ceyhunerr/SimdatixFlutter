// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

enum loginStatus{sabit,yukleniyor,girisYapildi,hata}
class UserControl with ChangeNotifier{
     loginStatus _durum = loginStatus.sabit;
    int _count =0;
    String _userid="";
    String _hataMesaj="";
    SharedPreferences? bilgi ;
    bool _userCheck=true;
     bool _loginWidget =true;

    int  get count => _count;
    bool get userCheck =>_userCheck;
    bool get loginWidget =>_loginWidget;

    String get userid =>_userid;
    String get hataMesaj =>_hataMesaj;
     loginStatus get durum => _durum;
    Future<void> getPreferences()async{
     bilgi = await SharedPreferences.getInstance();
   }

  Future<void> userControl()async{
   await getPreferences();
    if(bilgi?.getString("id")==null){
      _userCheck=false;
      notifyListeners();
    }else{
      _userid="${bilgi?.getString("id").toString()}";
      _userCheck=true;
      notifyListeners();
    }

  }

 Future login(String email, String sifre)async{
      _durum=loginStatus.yukleniyor;
      Map<String,dynamic> body ={
        "email" : email,
        "password" :sifre,

      };
      String encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
      var result =await http.post(
        Uri.parse('https://anybwnk52i.execute-api.eu-central-1.amazonaws.com/test/login'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding:Encoding.getByName('utf-8'),
        body: encodedBody,

      );
      final jsondata = json.decode(result.body);
      if(jsondata["success"].toString()=="false"){
        _durum = loginStatus.hata;
        _hataMesaj=jsondata["message"].toString();
      }else{
        _hataMesaj="";
        _durum = loginStatus.girisYapildi;
        savePreferences(jsondata["data"]["userId"].toString());
        change(1);
        changeLogin(true);
        
      }

  }

  void savePreferences(String id)async{
    await getPreferences();
    bilgi?.setString("id", id);
    notifyListeners();
  }

   void removePreferences()async{
     bilgi?.clear();
     notifyListeners();
   }

    change(int i){
      _count=i;
      notifyListeners();
    }

     changeLogin(bool i){
       _loginWidget=i;
       notifyListeners();
     }
}