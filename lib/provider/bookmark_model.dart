 import 'package:flutter/cupertino.dart';

class WordBloc extends ChangeNotifier{

  int _count = 0;
  List<String> items = [];

  void addItems(String data){
    items.add(data);
    _count++;
    notifyListeners();
  }

  void removeItems(String data){
    items.remove(data);
    _count--;
    notifyListeners();
  }


  int get getCount{
    return _count;
  }

  List<String> get itemsList{
    return items;
  }
}