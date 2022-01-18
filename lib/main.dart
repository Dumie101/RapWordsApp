import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/dataparsing.dart';
import 'package:flutterapp/getwords.dart';

void main() => runApp(const MyApp());


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  List<RhymeWord>? _rhymeWords;
  bool? _loading;


  @override
  void initState(){
    super.initState();
  }




  @override
  Widget build(BuildContext context){

    Widget customSearchBar = const Text('Rap Words Generator');
    final _textController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          centerTitle: true,
        ),


        body:
          Column (
            children: [
              TextField(
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


      )
    );
  }
}
