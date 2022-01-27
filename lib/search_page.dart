import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/get_words.dart';
import 'package:flutterapp/main.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();

    return MaterialApp(home: SearchBar(textController: _textController));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 35, top: 30, right: 30, bottom: 0),
              child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: IconButton(
                          padding: EdgeInsets.only(left: 20),
                          onPressed: () {
                            _textController.clear();
                          },
                          icon: Icon(Icons.clear))),
                  onSubmitted: (value) {
                    Services.getRhymeWords(value).then((rhymeWords) {
                      List<Color> colors =  List.generate(rhymeWords.length, (index) => Colors.blueGrey);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyMainPage(words: rhymeWords, colors: colors,)));
                    });
                  }),
            ),
          ],
        ));
  }
}
