import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/dataparsing.dart';
import 'package:flutterapp/getwords.dart';
import 'package:flutterapp/homepage.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();

    return MaterialApp(home: Builder(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(left: 35, top: 30, right: 30, bottom: 0),
            child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: IconButton(
                        padding: EdgeInsets.only(left:20),
                        onPressed: () {
                          _textController.clear();
                        },
                        icon: Icon(Icons.clear))),
                onSubmitted: (value) {
                  Services.getRhymeWords(value).then((rhymeWords) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyMainPage(words: rhymeWords)));
                  });
                }),
          ),
        ],
      ));
    }));
  }
}
