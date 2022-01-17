import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:http/http.dart' as http;

class HotelView extends StatefulWidget {
  final String footer;
  const HotelView({this.footer});

  @override
  _HotelView createState() => _HotelView();
}

class _HotelView extends State<HotelView> {
  Stream<List> CallApi() async* {
    var target = await http.get(Uri.parse("http://192.168.1.17:8080/hotel"));
    var result = jsonDecode(target.body);

    yield result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CallApi();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black87,
          elevation: 0,
          title: Text(widget.footer),
        ),
        body: Container(
            decoration: const BoxDecoration(color: Colors.black87),
            child: StreamBuilder(
              stream: CallApi(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return SafeArea(
                    child: Container(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              collapsedIconColor: Colors.white,
                              iconColor: Colors.white,
                              collapsedBackgroundColor: Colors.black,
                              title: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 10),
                                height: 150,
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.black26, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Image.asset(
                                                      'assets/avatar.png'),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data[index]["nom"]}"
                                                      .capitalizeFirst,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontFamily:
                                                          "NewsCycle-Bold"),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "${snapshot.data[index]["prenom"]}"
                                                        .capitalizeFirst,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            "NewsCycle-Bold")),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.login,
                                                      color: Colors.green,
                                                    ),
                                                    Text(
                                                      "Entrée:${snapshot.data[index]["entre"].split(" ")[0]}"
                                                          .capitalizeFirst,
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.logout,
                                                      color: Colors.redAccent,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Sortie:${snapshot.data[index]["sortie"].split(" ")[0]}"
                                                            .capitalizeFirst,
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 60, left: 20),
                                  height: 200,
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.black26, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Pays:${snapshot.data[index]["pays"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Chambre: ${snapshot.data[index]["chambre"]}",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      const Icon(
                                                        Icons.bed_outlined,
                                                        color:
                                                            Colors.blueAccent,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Adultes: ${snapshot.data[index]["adulte"]}",
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      const Icon(
                                                        Icons.family_restroom,
                                                        color:
                                                            Colors.cyanAccent,
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    "Logement:${snapshot.data[index]["logement"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Destination:${snapshot.data[index]["destination"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Etoiles:${snapshot.data[index]["etoiles"]}",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Enfants:${snapshot.data[index]["enfant"]}",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      const Icon(
                                                        Icons.child_care_sharp,
                                                        color:
                                                            Colors.pinkAccent,
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    "Vue:${snapshot.data[index]["vue"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),

                      /*ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              height: 150,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.black26, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Image.asset(
                                                    'assets/avatar.png'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${snapshot.data[index]["nom"]}"
                                                    .capitalizeFirst,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        "NewsCycle-Bold"),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  "${snapshot.data[index]["prenom"]}"
                                                      .capitalizeFirst,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontFamily:
                                                          "NewsCycle-Bold")),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on_outlined,
                                                    color: Colors.pinkAccent,
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index]["adresse"]}"
                                                        .capitalizeFirst,
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.email_outlined,
                                                    color: Colors.blueAccent,
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index]["email"]}",
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index]["phone"]}",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })*/
                    ),
                  );
                } else {
                  return Container(
                    child: Center(child: const CircularProgressIndicator()),
                  );
                }
              },
            )),
      ),
    );
  }
}
