import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/appfiles/home_page.dart';
import 'package:flutterapp/api/data_parsing.dart';
import 'package:flutterapp/provider/bookmark_model.dart';
import 'package:flutterapp/api/get_words.dart';
import 'package:provider/provider.dart';
import 'fav_page.dart';

class MyMainPage extends StatefulWidget {
  final List<RhymeWord>? words;
  final List<Color> colors;
  final String wordSearched;

  const MyMainPage(
      {Key? key,
      required this.words,
      required this.colors,
      required this.wordSearched})
      : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState(
      words: words, colors: colors, wordSearched: wordSearched);
}

class _MyMainPageState extends State<MyMainPage> {
  _MyMainPageState(
      {required this.words, required this.colors, required this.wordSearched});

  List<RhymeWord>? words;
  List<Color> colors;
  String wordSearched;

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    bool containsWords = words!.isNotEmpty;
    final _textController = TextEditingController();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.lightBlue,
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: isSearching
                ? AppBarSearchBar(textController: _textController)
                : const Text("Rhyme Words",
                    style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                  icon: isSearching
                      ? const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (containsWords == true)
                Card(
                    color: Colors.lightBlue,
                    child: ListTile(
                        title: Text(wordSearched,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white)))),
              containsWords == true
                  ? Expanded(
                      child: ListView.builder(
                          itemCount:
                              null == widget.words ? 0 : widget.words!.length,
                          itemBuilder: (context, index) {
                            RhymeWord rhymeWord = widget.words![index];
                            var wordBloc = Provider.of<WordBloc>(context);
                            return Card(
                              color: Colors.lightBlue,
                              child: ListTile(
                                  title: Text(
                                    rhymeWord.word,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onTap: () {
                                    Services.getRhymeWords(rhymeWord.word)
                                        .then((rhymeWords) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyMainPage(
                                                  words: rhymeWords,
                                                  colors: colors,
                                                  wordSearched:
                                                      rhymeWord.word)));
                                    });
                                  },
                                  trailing: IconButton(
                                    icon: wordBloc.items
                                            .contains(rhymeWord.word)
                                        ? Icon(Icons.star, color: colors[index])
                                        : const Icon(Icons.star_border,
                                            color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        if (!wordBloc.items
                                            .contains(rhymeWord.word)) {
                                          colors[index] = Colors.white;
                                          wordBloc.addItems(rhymeWord.word);
                                        } else {
                                          wordBloc.removeItems(rhymeWord.word);
                                        }
                                      });
                                    },
                                  )),
                            );
                          }),
                    )
                  : const TextViewForNoWords()
            ],
          ),
          bottomNavigationBar: const BuildBottomNav(),
        ));
  }
}

class AppBarSearchBar extends StatelessWidget {
  const AppBarSearchBar({
    Key? key,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.white)),
        controller: _textController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        onSubmitted: (userInput) {
          Services.getRhymeWords(userInput).then((rhymeWords) {
            List<Color> colors =
                List.generate(rhymeWords.length, (index) => Colors.lightGreen);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyMainPage(
                        words: rhymeWords,
                        colors: colors,
                        wordSearched: userInput)));
          });
        });
  }
}

class TextViewForNoWords extends StatelessWidget {
  const TextViewForNoWords({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: const TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TyperAnimatedText('No Rhyme Words Found.'),
            TyperAnimatedText('Search Again.')
          ],
        ),
      ),
    );
  }
}

class BuildBottomNav extends StatelessWidget {
  const BuildBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
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
                      MaterialPageRoute(builder: (context) => const FavPage()));
                },
                icon: const Icon(Icons.star, color: Colors.black)),
            label: 'Favourite'),
      ],
    );
  }
}
