import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:http/http.dart' as http;

class VoyageView extends StatefulWidget {
  final String footer;
  const VoyageView({this.footer});

  @override
  _VoyageViewState createState() => _VoyageViewState();
}

class _VoyageViewState extends State<VoyageView> {
  Future CallApi() async {
    var target = await http.get(Uri.parse("http://192.168.1.17:8080/voyages"));
    var result = jsonDecode(target.body);

    return result;
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
            child: FutureBuilder(
              future: CallApi(),
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.login,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    "Depart:${snapshot.data[index]["depart"].split(" ")[0]}",
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on_outlined,
                                                    color: Colors.redAccent,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Destination: ${snapshot.data[index]["destination"]}"
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
                                                    "Type: ${snapshot.data[index]["type"]}"
                                                        .capitalizeFirst,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Chambre: ${snapshot.data[index]["chambre"]}"
                                                            .capitalizeFirst,
                                                        style: const TextStyle(
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
                                                        "Adultes: ${snapshot.data[index]["adulte"]}"
                                                            .capitalizeFirst,
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
                                                    "Interets: ${snapshot.data[index]["interets"]}"
                                                        .capitalizeFirst,
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Jours: ${snapshot.data[index]["jours"]}"
                                                            .capitalizeFirst,
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      const Icon(
                                                        Icons.timelapse_sharp,
                                                        color:
                                                            Colors.purpleAccent,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Enfants: ${snapshot.data[index]["enfant"]}"
                                                            .capitalizeFirst,
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      const Icon(
                                                        Icons.child_care_sharp,
                                                        color:
                                                            Colors.pinkAccent,
                                                      )
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
                                )
                              ],
                            );
                          }),
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
