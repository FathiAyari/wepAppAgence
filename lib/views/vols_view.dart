import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VolsView extends StatefulWidget {
  final String footer;
  const VolsView({this.footer});

  @override
  _VolsViewState createState() => _VolsViewState();
}

class _VolsViewState extends State<VolsView> {
  Future CallApi() async {
    var target = await http.get(Uri.parse("http://192.168.1.17:8080/hotel"));
    var result = jsonDecode(target.body);

    return result;
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
            child: FutureBuilder(
              future: CallApi(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return SafeArea(
                    child: Container(
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return ListTile();
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
