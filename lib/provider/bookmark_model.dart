 import 'package:flutter/cupertino.dart';
import 'package:flutterapp/provider/word_model.dart';

class WordBloc extends ChangeNotifier{

  int _count = 0;

  List<String> items = [];


  void addItems(String data){
    items.add(data);
    notifyListeners();
  }

  void count(){
    _count++;
    notifyListeners();
  }

  int get getCount{
    return _count;
  }

  List<String> get itemsList{
    return items;
  }


}