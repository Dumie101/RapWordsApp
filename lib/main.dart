import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/dataparsing.dart';
import 'package:flutterapp/getwords.dart';

void main() => runApp(const MyApp());


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}


class _Home extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(

              body: Image.asset('assets/images/clip-art-rapper-drawing-rappers-black-and-white-clothing-apparel-hood-helmet-transparent-png-831931.png'),

            );
          }
        )
    );
  }


}




class _MyAppState extends State<MyApp>{

  List<RhymeWord>? _rhymeWords;

  @override
  void initState(){
    super.initState();
  }

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


