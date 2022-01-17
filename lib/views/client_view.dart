import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:http/http.dart' as http;

class ClientView extends StatefulWidget {
  final String footer;
  const ClientView({this.footer});

  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  Future CallApi() async {
    var target = await http.get(Uri.parse("http://192.168.1.17:8080/clients"));
    var result = jsonDecode(target.body);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                          }),
                    ),
                  );
                } else {
                  return Container(
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
              },
            )),
      ),
    );
  }
}
