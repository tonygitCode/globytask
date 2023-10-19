import 'dart:convert';
import 'package:http/http.dart ' as http;
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List postJson = [];

  void apitwo() async {
    String url = 'https://demo.athemes.com/wp-json/wp/v2/posts/2926';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        postJson = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apitwo();
    postJson;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('SecondScreen'),
            elevation: 1,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 500,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postJson.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(postJson[i]['title']),
                          subtitle: Text(postJson[i]['id'].toString()),
                        );
                      }),
                ),
              ),
            ],
          )),
    );
  }
}
