import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/landing_page.dart';
import 'package:flutterapp/data_parsing.dart';
import 'package:flutterapp/provider/bookmark_model.dart';
import 'package:flutterapp/search_page.dart';
import 'package:flutterapp/get_words.dart';
import 'package:provider/provider.dart';

import 'fav_page.dart';

class MyMainPage extends StatefulWidget {
  final List<RhymeWord>? words;
  final List<Color> colors;

  const MyMainPage({Key? key, required this.words, required this.colors})
      : super(key: key);

  @override
  _MyMainPageState createState() =>
      _MyMainPageState(words: words, colors: colors);
}

class _MyMainPageState extends State<MyMainPage> {
  _MyMainPageState({required this.words, required this.colors});

  List<RhymeWord>? words;
  List<Color> colors;

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    bool containsWords = words!.isNotEmpty;
    final _textController = TextEditingController();

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: isSearching
            ? TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Search ..."
          ),
                controller: _textController,
                onSubmitted: (value) {
                  Services.getRhymeWords(value).then((rhymeWords) {
                    List<Color> colors = List.generate(
                        rhymeWords.length, (index) => Colors.blueGrey);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyMainPage(words: rhymeWords, colors: colors)));
                  });
                })
            : Text("Rhyme Words", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: isSearching ? Icon(
                Icons.cancel,
                color: Colors.black,
              )  : Icon(
                Icons.search,
                color: Colors.black,
              )
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          containsWords == true
              ? Expanded(
                  child: ListView.builder(
                      itemCount:
                          null == widget.words ? 0 : widget.words!.length,
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
                                Services.getRhymeWords(rhymeWord.word)
                                    .then((rhymeWords) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyMainPage(
                                              words: rhymeWords,
                                              colors: colors)));
                                });
                              },
                              trailing: IconButton(
                                icon: Icon(Icons.star, color: colors[index]),
                                onPressed: () {
                                  setState(() {
                                    print(colors[index]);
                                    if (colors[index] == Colors.blueGrey) {
                                      colors[index] = Colors.green;
                                      wordBloc.addItems(rhymeWord.word);
                                    } else {
                                      colors[index] = Colors.blueGrey;
                                      wordBloc.removeItems(rhymeWord.word);
                                    }
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
