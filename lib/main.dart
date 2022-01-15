import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivawgo/splash_screen.dart';

Future<void> main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var isViewed;
  getViewed() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences test = await SharedPreferences.getInstance();
    isViewed = await test.getInt('Onboard');
    print(isViewed);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    getViewed();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(body: SplasScreen()));
  }
}

/*class MyApp extends StatelessWidget {
  getViewed() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences test = await SharedPreferences.getInstance();
    isViewed = await test.getInt('Onboard');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: isViewed != 0 ? onboarding() : home_page(),
        ));
  }
}*/

class call extends StatefulWidget {
  @override
  _callState createState() => _callState();
}

class _callState extends State<call> {
  Future callApi() async {
    var url = Uri.parse("http://192.168.1.17:8080/hotel");
    var response = await http.get(url);
    var body = response.body;
    var mybody = await jsonDecode(response.body);
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
        if (snapshot.hasData) {
          return SafeArea(
            child: Container(
              child: Text("${snapshot.data[1]["nom"]}"),
            ),
          );
        } else {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
