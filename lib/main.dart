import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
        body: call(),
      )
    );
  }
}

class call extends StatefulWidget {


  @override
  _callState createState() => _callState();
}

class _callState extends State<call> {
  Future callApi()async {
    var url=Uri.parse("http://192.168.1.17:8080/hotel");
    var response = await http.get(url);
    var body=response.body;
    var mybody=await jsonDecode(response.body);
    return mybody;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: callApi(),
   builder: (BuildContext context, AsyncSnapshot snapshot) {
   if(snapshot.hasData){
     return SafeArea(
       child: Container(
         child: Text("${snapshot.data[1]["nom"]}"),
       ),
     );
   }else{
     return Container(
       child: CircularProgressIndicator(),
     );
   }
   },
    );
  }
}

