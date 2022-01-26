import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/landing_page.dart';
import 'package:flutterapp/data_parsing.dart';
import 'package:flutterapp/provider/bookmark_model.dart';
import 'package:flutterapp/provider/word_model.dart';
import 'package:flutterapp/search_page.dart';
import 'package:flutterapp/get_words.dart';
import 'package:provider/provider.dart';

import 'fav_page.dart';

class MyMainPage extends StatefulWidget {
  final List<RhymeWord>? words;

  const MyMainPage({Key? key, required this.words}) : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState(words: words);
}

class _MyMainPageState extends State<MyMainPage> {
  _MyMainPageState({required this.words});

  List<RhymeWord>? words;
  late Color normalColor = Colors.blueGrey;


  @override
  Widget build(BuildContext context) {
    bool containsWords = words!.isNotEmpty;

    return MaterialApp(
        home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          containsWords == true
              ? Expanded(
                child: ListView.builder(
                itemCount: null == widget.words ? 0 : widget.words!.length,
                itemBuilder: (context, index) {
                  RhymeWord rhymeWord = widget.words![index];
                  var wordBloc = Provider.of<WordBloc>(context);
                  return Card(
                    child: ListTile(
                        title: Text(
                          rhymeWord.word,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Services.getRhymeWords(rhymeWord.word).then((rhymeWords) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyMainPage(words: rhymeWords)));
                          });
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.star, color: normalColor),
                          onPressed: () {
                            setState(() {
                              if ( normalColor == Colors.blueGrey){
                                normalColor = Colors.green;
                              } else {
                                normalColor = Colors.blueGrey;
                              }
                              wordBloc.count();
                              wordBloc.addItems(rhymeWord.word);
                            });
                          },
                        )),
                  );
                    }),
              )
              : TextViewForNoWords()
        ],
      ),
      bottomNavigationBar: buildBottomNav(),
    ));
  }
}

class buildBottomNav extends StatelessWidget {
  const buildBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                icon: const Icon(Icons.search)),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavPage()));
                },
                icon: const Icon(Icons.feed_outlined)),
            label: 'Notepad'),
      ],
    );
  }
}

class TextViewForNoWords extends StatelessWidget {
  const TextViewForNoWords({
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

class ListViewOfRhymeWords extends StatefulWidget {
  const ListViewOfRhymeWords({
    Key? key,
    required this.words,
  }) : super(key: key);

  final List<RhymeWord>? words;

  @override
  State<ListViewOfRhymeWords> createState() => _ListViewOfRhymeWordsState();
}

class _ListViewOfRhymeWordsState extends State<ListViewOfRhymeWords> {

  late Color normalColor;

  @override
  Widget build(BuildContext context) {

    normalColor = Colors.blueGrey;

    return Expanded(
        child: ListView.builder(
            itemCount: null == widget.words ? 0 : widget.words!.length,
            itemBuilder: (context, index) {
              RhymeWord rhymeWord = widget.words![index];
              var wordBloc = Provider.of<WordBloc>(context);

              return Card(
                child: ListTile(
                    title: Text(
                      rhymeWord.word,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Services.getRhymeWords(rhymeWord.word).then((rhymeWords) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyMainPage(words: rhymeWords)));
                      });
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.star, color: normalColor),
                      onPressed: () {
                        setState(() {
                          if ( normalColor == Colors.blueGrey){
                            normalColor == Colors.green;
                          } else {
                            normalColor == Colors.blueGrey;
                          }
                        });
                      },
                    )),
              );
            }));
  }
}
