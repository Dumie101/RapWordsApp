import 'package:flutterapp/dataparsing.dart';
import 'package:http/http.dart' as http;




class Services{


  static Future<List<RhymeWord>> getRhymeWords(String value) async{

      String url = 'https://api.datamuse.com/words?rel_rhy=' + value;

      final response = await http.get(Uri.parse(url));

      if(200 == response.statusCode){

        final List<RhymeWord> rhymeWords = rhymeWordFromJson(response.body);
        return rhymeWords;

      }else{
        throw Exception('Failed to load words ll');
      }


  }




}