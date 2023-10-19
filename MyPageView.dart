import 'package:flutter/material.dart';

import 'FirstPage.dart';
import 'SecondPage.dart';

class MyPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: const [
          FirstPage(),
          SecondPage(),
        ],
      ),
    );
  }
}
