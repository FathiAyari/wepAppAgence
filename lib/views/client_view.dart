import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClientView extends StatefulWidget {
  final String footer;
  const ClientView({this.footer});

  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  Future CallApi() async {
    var target = await http.get(Uri.parse("http://192.168.1.17:8080/"));
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
                            return Text(
                              "${snapshot.data[index][0]}",
                              style: TextStyle(color: Colors.white),
                            );
                          }),
                    ),
                  );
                } else {
                  return Container(
                    child: const CircularProgressIndicator(),
                  );
                }
              },
            )),
      ),
    );
  }
}
