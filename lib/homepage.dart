import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/homepage.dart';
import 'package:flutterapp/getwords.dart';
import 'package:flutterapp/dataparsing.dart';






class MyAppState extends State<MyApp>{

  List<RhymeWord>? _rhymeWords;


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
                                _rhymeWords = rhymeWords;
                              });
                            });
                          }
                      ),
                    ),

                    Expanded(child: ListView.builder(
                        itemCount: null == _rhymeWords ? 0 : _rhymeWords!.length,
                        itemBuilder: (context, index){
                          RhymeWord rhymeWord = _rhymeWords![index];
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




