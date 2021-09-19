import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simdatixtest/provider/apiClient.dart';
import 'package:simdatixtest/provider/userProvider.dart';
import 'package:simdatixtest/src/homenav.dart';

void main(){

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SimdatixTest',
        theme: ThemeData(
        ),
        home: HomeNav(),
      ),

      providers: [
        ChangeNotifierProvider(create: (context)=>UserControl()),
        ChangeNotifierProvider(create: (context)=>ApiClient()),
      ],
    );
  }
}
