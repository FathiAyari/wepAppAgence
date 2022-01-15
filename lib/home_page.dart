import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:trivawgo/clicked_item.dart';

class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  var mytoken;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future callApi() async {
    List count = [2];

    List api = [
      "http://192.168.1.17:8080/hotels",
      "http://192.168.1.17:8080/voyages",
      "http://192.168.1.17:8080/clients",
    ];

    var countItems =
        await http.get(Uri.parse("http://192.168.1.17:8080/entities"));
    var result = jsonDecode(countItems.body);
    result.add(1);
    return result;
  }

  List<Color> colorsList = [
    Color(0xffB655FB),
    Color(0xff666AF6),
    Colors.pinkAccent,
    Colors.lightBlueAccent,
  ];
  List<Content> contentList = [
    Content(
      image: 'assets/clients.png',
      footer: 'Les Clients',
    ),
    Content(
      image: 'assets/vol.png',
      footer: 'Les Vols',
    ),
    Content(
      image: 'assets/hotel.png',
      footer: 'Les Hotels',
    ),
    Content(
      image: 'assets/voyage.png',
      footer: 'Les Voyages',
    ),
  ];

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(" Non"));
  }

  Widget Positive() {
    return Container(
      decoration: const BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    callApi();
    /*firebaseMessaging.getToken().then((token) {
      assert(token != null);
      setState(() {
        mytoken = token;
        print(mytoken);
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black87,
          body: WillPopScope(
            onWillPop: () {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      content: const Text(" êtes-vous sûr de sortir ?"),
                      actions: [Negative(context), Positive()],
                    );
                  });
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.black87),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Bonjour Mr Hosni.",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/avatar.png'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: callApi(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              itemCount: contentList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: (2),
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15),
                              itemBuilder: (context, int index) {
                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    contentList[index],
                                    Stack(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 2),
                                        child: CircleAvatar(
                                          backgroundColor: colorsList[index],
                                          child: Text(
                                            "${snapshot.data[index]}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 5, start: 2),
                                        child: CircleAvatar(
                                          radius: 5,
                                          backgroundColor: Colors.green,
                                        ),
                                      )
                                    ]),
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class Content extends StatelessWidget {
  final String image;
  final Color color;
  final String footer;
  Content({
    Key key,
    this.image,
    this.footer,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ClickedItem(
          footer: footer,
        ));
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*         Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              ],
            ),*/
            Expanded(
                flex: 2,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                )),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  footer,
                  style:
                      const TextStyle(fontSize: 20, fontFamily: "EBGaramond"),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
