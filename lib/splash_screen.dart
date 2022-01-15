import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivawgo/home_page.dart';
import 'package:trivawgo/onboardingPage/onboarding.dart';

class SplasScreen extends StatefulWidget {
  @override
  _SplasScreenState createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  int isViewed;
  getViewed() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences test = await SharedPreferences.getInstance();
    isViewed = await test.getInt('Onboard');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getViewed();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isViewed != 0 ? onboarding() : home_page())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/voyages.png',
              width: size.width * 0.9,
            ),
          ),
          Container(
            child: const Text(
              "Triva Go ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Teko-Medium',
              ),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
