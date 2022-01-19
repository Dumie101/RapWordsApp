import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/homepage.dart';
import 'package:flutterapp/getwords.dart';
import 'package:flutterapp/dataparsing.dart';


class MyMainPage extends StatefulWidget {
  final List<RhymeWord>? words;
  const MyMainPage({Key? key, required this.words}) : super(key: key);



  @override
  _MyMainPageState createState() => _MyMainPageState(words:words);
}


class _MyMainPageState extends State<MyMainPage>{
  List<RhymeWord>? words;
  _MyMainPageState({required this.words}){}


  @override
  Widget build(BuildContext context){

    Widget customSearchBar = const Text('Rap Words Generator');
    final _textController = TextEditingController();

    return MaterialApp(
        home: Builder(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: customSearchBar,
                  centerTitle: true,
                ),
                body:
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                              hintText: 'Search',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(onPressed: (){
                                _textController.clear();
                              }, icon: Icon(Icons.clear))

                          ),

                          onSubmitted:(value){
                            Services.getRhymeWords(value).then((rhymeWords) {
                              setState(() {
                                words = rhymeWords;
                              });
                            });
                          }
                      ),
                    ),

                    Expanded(child: ListView.builder(
                        itemCount: null == words ? 0 : words!.length,
                        itemBuilder: (context, index){
                          RhymeWord rhymeWord = words![index];
                          return ListTile(
                            title: Text(rhymeWord.word),
                          );
                        })
                    )
                  ],
                ),

                bottomNavigationBar: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: IconButton(onPressed: (){
                          // Nav
                        }, icon: const Icon(Icons.arrow_back_ios)),
                        label: 'Back'
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.article_sharp),
                      label: 'Notepad',
                    ),
                  ],
                ),
              );
            }
        )
    );
  }


}




