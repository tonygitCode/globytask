import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'model_one.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    List<Posts> _list = [];
    List<Posts> _search = [];
    var loading = false;

    Future<Null> fetchData() async {
      setState(() {
        loading = true;
      });

      var url = 'https://demo.athemes.com/wp-json/wp/v2/posts';
      _list.clear();
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          for (Map i in data) {
            _list.add(Posts.fromJson(Map.identity()));
            loading = false;
          }
        });
      }
    }

    onsearch(String text) {
      _search.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }
      _list.forEach((f) {
        if (f.link.contains(text) || f.slug.contains(text)) _search.add(f);
      });
      setState(() {});
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      fetchData();
    }

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 590,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Container(
                      color: Colors.purple.shade100,
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.search),
                          title: TextField(
                            controller: controller,
                            onChanged: onsearch,
                            decoration: const InputDecoration(
                              hintText: 'search',
                              border: InputBorder.none,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              controller.clear();
                              onsearch('');
                            },
                            icon: Icon(Icons.backspace_outlined),
                          ),
                        ),
                      ),
                    ),
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: _search.length != 0 ||
                                    controller.text.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _search.length,
                                    itemBuilder: (context, i) {
                                      final b = _search[i];
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Card(
                                            color: Colors.purple.shade100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(b.link,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          Card(
                                              color: Colors.green.shade100,
                                              child: Text(b.slug)),
                                        ],
                                      );
                                    })
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _list.length,
                                    itemBuilder: (context, i) {
                                      final a = _list[i];
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Card(
                                            color: Colors.purple.shade100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(a.link,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          Card(
                                              color: Colors.green.shade100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(a.slug),
                                              )),
                                        ],
                                      );
                                    }),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
