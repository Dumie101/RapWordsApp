import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/homepage.dart';
import 'package:flutterapp/getwords.dart';
import 'package:flutterapp/dataparsing.dart';
import 'package:flutterapp/searchpage.dart';

class MyMainPage extends StatefulWidget {
  final List<RhymeWord>? words;

  const MyMainPage({Key? key, required this.words}) : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState(words: words);
}

class _MyMainPageState extends State<MyMainPage> {
  List<RhymeWord>? words;

  _MyMainPageState({required this.words});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Builder(builder: (context) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [NewWidget(words: words)],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: const Icon(Icons.home)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                    },
                    icon: const Icon(Icons.search)),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    icon: const Icon(Icons.feed_outlined)),
                label: 'Notepad'),
          ],
        ),
      );
    }));
  }
}

class NewWidget2 extends StatelessWidget {
  const NewWidget2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TyperAnimatedText('No Rhyme Words Found.'),
              TyperAnimatedText('Search Again.')
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.words,
  }) : super(key: key);

  final List<RhymeWord>? words;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: null == words ? 0 : words!.length,
            itemBuilder: (context, index) {
              RhymeWord rhymeWord = words![index];
              return Card(
                child: ListTile(
                  title: Text(
                    rhymeWord.word,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }));
  }
}
