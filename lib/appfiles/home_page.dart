import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/api/get_words.dart';
import 'package:flutterapp/appfiles/main_page.dart';
import 'package:flutterapp/provider/bookmark_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    ChangeNotifierProvider(create: (_) => WordBloc(), child: const HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _LandingPage();
}

class _LandingPage extends State<HomePage> {
  final _textController = TextEditingController();
  List<Color> colors = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Builder(builder: (context) {
      return Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Image.asset('assets/images/output-onlinepngtools (2).png'),
            margin:
                const EdgeInsets.only(left: 0, top: 100, right: 0, bottom: 0),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 35, top: 0, right: 0, bottom: 0),
            child: DefaultTextStyle(
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText('Rhyme Word Generator',
                      speed: const Duration(milliseconds: 100)),
                ],
              ),
            ),
          ),
          Expanded(
            child: SearchBar(textController: _textController),
          )
        ],
      ));
    }));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required TextEditingController textController,
  }) : _textController = textController, super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 35, top: 30, right: 35, bottom: 0),
      child: TextField(
          controller: _textController,
          decoration: InputDecoration(
              hintText: "Search ...",
              suffixIcon: IconButton(
                  padding: const EdgeInsets.only(left: 20),
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: const Icon(Icons.clear))),
          onSubmitted: (userInput) {
            Services.getRhymeWords(userInput).then((rhymeWords) {
              List<Color> colors = List.generate(
                  rhymeWords.length, (index) => Colors.blueGrey);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyMainPage(
                          words: rhymeWords, colors: colors)));
            });
          }),
    );
  }
}